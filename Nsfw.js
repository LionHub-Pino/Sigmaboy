const { Client, GatewayIntentBits, EmbedBuilder, ActionRowBuilder, ButtonBuilder, ButtonStyle, StringSelectMenuBuilder } = require('discord.js');
const axios = require('axios');
const { GoogleGenerativeAI } = require("@google/generative-ai");

// --- 🔑 KHU VỰC ĐIỀN KEY (ÔNG ĐIỀN VÀO ĐÂY) ---
const TOKEN = 'DÁN_TOKEN_BOT_DISCORD_CỦA_ÔNG'; 
const GEMINI_API_KEY = 'DÁN_GEMINI_KEY_TẠI_AISTUDIO.GOOGLE.COM'; 

const R34_CONFIG = {
    uid: '6026073',
    key: '1340768a6dbce4f80f1924ab8f8e8fe5fbb21761a5af73e90953fc99dd37a283c86c4c002dd2d40fafd1bd5852fca85716fb5cb6bf4fcd928e0df85c358c015c'
};

// --- 🧠 KHỞI TẠO BỘ NÃO GEMINI ---
const genAI = new GoogleGenerativeAI(GEMINI_API_KEY);
const aiModel = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

// --- 🤖 KHỞI TẠO CON BOT ---
const bot = new Client({
    intents: [GatewayIntentBits.Guilds, GatewayIntentBits.GuildMessages, GatewayIntentBits.MessageContent]
});

const boNhoTam = new Map(); // Lưu phiên lướt ảnh của anh em
const treoMay = new Map();  // Lưu mấy kênh đang chạy auto-post

bot.once('ready', () => {
    console.log(`\n✅ BOT ĐÃ LÊN ĐÈN: ${bot.user.tag}`);
    console.log(`🔥 PHIÊN BẢN: THE GODFATHER V9.0 (ANTI-GORE & AI GEMINI)`);
    console.log(`🚀 SẴN SÀNG PHỤC VỤ ÔNG GIÁO!\n`);
});

bot.on('messageCreate', async (msg) => {
    if (msg.author.bot) return;

    // Chặn anh em dùng hàng NSFW ở kênh thường (kẻo bay màu server)
    if (msg.content.startsWith('!') && !msg.channel.nsfw) {
        return msg.reply('🔞 Chỗ này "sáng" quá ông giáo ơi! Qua kênh **NSFW** anh em mình đàm đạo.');
    }

    const args = msg.content.split(' ');
    const lenh = args[0].toLowerCase();

    // --- 1. LỆNH HELP (BẢNG ĐIỀU KHIỂN) ---
    if (lenh === '!help') {
        const h = new EmbedBuilder()
            .setTitle('🔞 TRUNG TÂM ĂN CHƠI R34')
            .setDescription('Chào ông giáo! Đây là mấy món đồ chơi xịn nhất tôi có:')
            .setColor('#7d5fff')
            .addFields(
                { name: '🖼️ `!r34 [tag]`', value: 'Tìm ảnh (có nút qua lại cực mượt).', inline: true },
                { name: '🎬 `!r34vid [tag]`', value: 'Menu chọn Video hàng cực phẩm.', inline: true },
                { name: '🎲 `!r34random`', value: 'Văng ra ảnh bất kỳ (hên xui).', inline: true },
                { name: '🤖 `!ai [câu hỏi]`', value: 'Hỏi tôi (Gemini) tư vấn chuyện thầm kín.', inline: true },
                { name: '🔄 `!r34loop [tag] [phút]`', value: 'Nuôi kênh (tự gửi ảnh theo thời gian).', inline: false },
                { name: '🗑️ Nút rác', value: 'Tự xóa tin nhắn nếu thấy "biến".', inline: true }
            )
            .setFooter({ text: '⚠️ Đã bật chặn máu me bạo lực (Anti-Gore) & lọc hàng rác!' });
        return msg.reply({ embeds: [h] });
    }

    // --- 2. LỆNH AI TƯ VẤN (GEMINI DÂN CHƠI) ---
    if (lenh === '!ai') {
        const cauHoi = args.slice(1).join(' ');
        if (!cauHoi) return msg.reply("Hỏi gì thì hỏi lẹ đi ông giáo, đừng ngại!");
        const dangKhan = await msg.reply("🔍 Chờ tí, tôi đang 'thẩm' câu hỏi...");
        try {
            const context = `Bạn tên là Gemini, một lão đại sành sỏi về Rule34. Nói chuyện bỗ bã, bụi bặm, xưng tôi - ông giáo. Tư vấn nhiệt tình nhưng cấm máu me bạo lực. Câu hỏi: ${cauHoi}`;
            const result = await aiModel.generateContent(context);
            await dangKhan.edit(`🤖 **Gemini Tư Vấn:**\n${result.response.text()}`);
        } catch (e) { await dangKhan.edit("🔥 Lỗi rồi, chắc não đang bận đi tắm!"); }
        return;
    }

    // --- 3. LỆNH TÌM ẢNH (R34) ---
    if (lenh === '!r34' || lenh === '!r34top' || lenh === '!r34random') {
        let tagSearch = args.slice(1).join(' ');
        let page = 0; let limit = 100;
        const camGore = ' -gore -blood -bloody -mutilation -death -dead -corpse -scat -vomit -guross';

        if (lenh === '!r34top') tagSearch += ' score:>100';
        if (lenh === '!r34random') {
            page = Math.floor(Math.random() * 500);
            limit = 1; tagSearch = ''; 
        }

        tagSearch += camGore; // Luôn âm thầm chặn máu me

        const data = await layDataR34(tagSearch, page, limit);
        if (data.length) {
            boNhoTam.set(msg.author.id, { data, index: 0, tagSearch: tagSearch.replace(camGore, '') });
            guiAnh(msg, msg.author.id);
        } else msg.reply("❌ Tìm không ra, hoặc hàng này bị tôi chặn vì quá kinh dị rồi!");
    }

    // --- 4. LỆNH CHỌN VIDEO (MENU) ---
    if (lenh === '!r34vid') {
        const tagVid = args.slice(1).join(' ') + " video -gore";
        const dataVid = await layDataR34(tagVid);
        if (!dataVid.length) return msg.reply("❌ Hết phim rồi ông giáo ơi!");
        const menu = new ActionRowBuilder().addComponents(
            new StringSelectMenuBuilder().setCustomId('chon_phim').setPlaceholder('🎬 Chọn bộ phim ưng ý...').addOptions(
                dataVid.slice(0, 25).map(v => ({
                    label: `ID: ${v.id}`, description: `Số má (Score): ${v.score}`, value: v.file_url.startsWith('http') ? v.file_url : 'https:' + v.file_url
                }))
            )
        );
        return msg.reply({ content: `📺 Hàng tuyển cho: \`${tagVid.replace(' video -gore','')}\``, components: [menu] });
    }

    // --- 5. LỆNH TREO MÁY NUÔI KÊNH ---
    if (lenh === '!r34loop') {
        const tagLoop = args[1];
        const phut = parseInt(args[2]) || 60;
        if (!tagLoop) return msg.reply("Cho cái tag để tôi còn biết đường 'nuôi' kênh chứ!");
        if (treoMay.has(msg.channel.id)) {
            clearInterval(treoMay.get(msg.channel.id)); treoMay.delete(msg.channel.id);
            return msg.reply("🛑 Đã dừng treo máy. Anh em nghỉ ngơi hồi sức!");
        }
        msg.reply(`✅ Đã bật chế độ lượm hàng tự động! Mỗi ${phut} phút tôi ném 1 ảnh \`${tagLoop}\` vào đây.`);
        const interval = setInterval(async () => {
            const data = await layDataR34(`${tagLoop} score:>20 -gore`, Math.floor(Math.random() * 20), 50);
            if (data.length) {
                const post = data[Math.floor(Math.random() * data.length)];
                const embed = new EmbedBuilder().setTitle(`🎁 Hàng tiếp tế: ${tagLoop}`).setImage(post.file_url).setColor('#f1c40f').setFooter({ text: `ID: ${post.id}` });
                msg.channel.send({ embeds: [embed] });
            }
        }, phut * 60 * 1000);
        treoMay.set(msg.channel.id, interval);
    }
});

// --- 🖱️ XỬ LÝ NÚT BẤM & MENU ---
bot.on('interactionCreate', async (i) => {
    if (i.isButton()) {
        const s = boNhoTam.get(i.user.id);
        if (!s) return i.reply({ content: "Hết hạn rồi ông giáo, gõ lại lệnh đi!", ephemeral: true });
        if (i.customId === 'prev') s.index = (s.index - 1 + s.data.length) % s.data.length;
        if (i.customId === 'next') s.index = (s.index + 1) % s.data.length;
        if (i.customId === 'del') return i.message.delete();
        const { embed, row } = taoGiaoDien(s);
        await i.update({ embeds: [embed], components: [row] });
    }
    if (i.isStringSelectMenu() && i.customId === 'chon_phim') {
        await i.reply({ content: `🎬 **Phim của ông giáo đây, xem lẹ đi:**\n${i.values[0]}` });
    }
});

// --- 🛠️ HÀM HỖ TRỢ (HELPERS) ---
async function layDataR34(tag, p = 0, lim = 100) {
    const filter = tag.includes('score:') ? '' : ' score:>15'; // Tự động lọc hàng rác
    const url = `https://api.rule34.xxx/index.php?page=dapi&s=post&q=index&limit=${lim}&pid=${p}&tags=${encodeURIComponent(tag + filter)}&json=1&user_id=${R34_CONFIG.uid}&api_key=${R34_CONFIG.key}`;
    try { const r = await axios.get(url); return r.data || []; } catch { return []; }
}

function taoGiaoDien(s) {
    const post = s.data[s.index];
    const linkGoc = post.file_url.startsWith('http') ? post.file_url : 'https:' + post.file_url;
    const laVideo = linkGoc.match(/\.(mp4|webm)$/i);
    const embed = new EmbedBuilder()
        .setTitle(`🔞 Hàng về: ${s.tagSearch}`)
        .setImage(laVideo ? post.preview_url : linkGoc)
        .addFields(
            { name: '📊 Số má', value: `ID: ${post.id} | Score: ${post.score}`, inline: true },
            { name: '📐 Thước tấc', value: `${post.width}x${post.height}`, inline: true },
            { name: '📂 Vị trí', value: `${s.index + 1}/${s.data.length}`, inline: true }
        ).setColor('#2ed573');
    const row = new ActionRowBuilder().addComponents(
        new ButtonBuilder().setCustomId('prev').setEmoji('⬅️').setStyle(ButtonStyle.Primary),
        new ButtonBuilder().setCustomId('next').setEmoji('➡️').setStyle(ButtonStyle.Primary),
        new ButtonBuilder().setCustomId('del').setEmoji('🗑️').setStyle(ButtonStyle.Danger),
        new ButtonBuilder().setLabel('Bản Gốc').setURL(linkGoc).setStyle(ButtonStyle.Link)
    );
    return { embed, row };
}

async function guiAnh(msg, uid) {
    const { embed, row } = taoGiaoDien(boNhoTam.get(uid));
    await msg.reply({ embeds: [embed], components: [row] });
}

bot.login(TOKEN);
