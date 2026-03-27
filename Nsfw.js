const { Client, GatewayIntentBits, EmbedBuilder, ActionRowBuilder, ButtonBuilder, ButtonStyle, StringSelectMenuBuilder, PermissionsBitField } = require('discord.js');
const axios = require('axios');
const { GoogleGenerativeAI } = require("@google/generative-ai");

// --- 🔑 CHỖ ĐIỀN KEY CỦA ÔNG GIÁO ---
const TOKEN = 'DÁN_TOKEN_BOT_CỦA_ÔNG'; 
const GEMINI_API_KEY = 'DÁN_GEMINI_KEY_CỦA_ÔNG'; 
const R34_CONFIG = {
    uid: '6026073',
    key: '1340768a6dbce4f80f1924ab8f8e8fe5fbb21761a5af73e90953fc99dd37a283c86c4c002dd2d40fafd1bd5852fca85716fb5cb6bf4fcd928e0df85c358c015c'
};

const genAI = new GoogleGenerativeAI(GEMINI_API_KEY);
const aiModel = genAI.getGenerativeModel({ model: "gemini-2.0-flash" });
const bot = new Client({ intents: [GatewayIntentBits.Guilds, GatewayIntentBits.GuildMessages, GatewayIntentBits.MessageContent] });

const boNhoTam = new Map(); 
const treoMay = new Map();  
const userStats = new Map(); 

bot.once('ready', () => {
    console.log(`\n🌪️  ========================================`);
    console.log(`   R34 CHAOS LORD V13.0 - 20 COMMANDS UNLOCKED`);
    console.log(`   PHỤC VỤ CHÚA TỂ: ${bot.user.tag}`);
    console.log(`======================================== 🌪️\n`);
});

bot.on('messageCreate', async (msg) => {
    if (msg.author.bot || !msg.channel.nsfw) return;

    const args = msg.content.split(' ');
    const cmd = args[0].toLowerCase();

    // Tăng XP mỗi khi chat
    let stats = userStats.get(msg.author.id) || { xp: 0, level: 1, daily: 0 };
    stats.xp += 2;
    if (stats.xp >= stats.level * 20) { stats.level++; stats.xp = 0; }
    userStats.set(msg.author.id, stats);

    // --- DANH SÁCH 20 LỆNH ĂN CHƠI ---

    // 1. !help - Tổng hợp
    if (cmd === '!help') {
        const h = new EmbedBuilder()
            .setTitle('🌪️ BẢNG LỆNH CHAOS LORD (20 LỆNH)')
            .setColor('#3ae374')
            .addFields(
                { name: '🖼️ Ảnh (6)', value: '`!r34`, `!r34top`, `!r34hd`, `!r34random`, `!r34new`, `!r34find`', inline: false },
                { name: '🎬 Phim (1)', value: '`!r34vid` (Menu phim)', inline: true },
                { name: '🤖 AI (2)', value: '`!ai`, `!suggest` (Gợi ý gu)', inline: true },
                { name: '🔄 Auto (2)', value: '`!r34loop`, `!stop` (Dừng loop)', inline: true },
                { name: '🔍 Công cụ (4)', value: '`!r34tag`, `!r34dl`, `!r34user`, `!r34sauce`', inline: false },
                { name: '📊 Cá nhân (4)', value: '`!profile`, `!rank`, `!r34daily`, `!r34best`', inline: false },
                { name: '🛡️ Quản trị (1)', value: '`!clean` (Dọn kênh)', inline: true }
            );
        return msg.reply({ embeds: [h] });
    }

    // 2. !ai - Gemini 2.0
    if (cmd === '!ai') {
        const res = await aiModel.generateContent(`Bạn là Gemini, dân chơi sành sỏi. Trả lời bỗ bã về: ${args.slice(1).join(' ')}`);
        return msg.reply(`🤖 **Gemini:** ${res.response.text()}`);
    }

    // 3 -> 6. Lệnh Search cơ bản
    if (['!r34', '!r34top', '!r34hd', '!r34random'].includes(cmd)) {
        let t = args.slice(1).join(' ');
        let p = 0; let lim = 100;
        if (cmd === '!r34top') t += ' score:>200';
        if (cmd === '!r34hd') t += ' width:>2000';
        if (cmd === '!r34random') { p = Math.floor(Math.random()*1000); lim = 1; t = ''; }
        const data = await layDataR34(t + ' -gore', p, lim);
        if (data.length) { boNhoTam.set(msg.author.id, { data, index: 0, tags: t || 'Random' }); guiAnh(msg, msg.author.id); }
        else msg.reply("❌ Tìm không thấy hàng ông giáo ơi!");
    }

    // 7. !r34new - Hàng mới lên kệ
    if (cmd === '!r34new') {
        const data = await layDataR34('-gore', 0, 10);
        boNhoTam.set(msg.author.id, { data, index: 0, tags: 'Hàng mới về' });
        guiAnh(msg, msg.author.id);
    }

    // 8. !r34find [tag1] [tag2] - Kết hợp
    if (cmd === '!r34find') {
        const t = `${args[1]} ${args[2]} -gore`;
        const data = await layDataR34(t);
        if (data.length) { boNhoTam.set(msg.author.id, { data, index: 0, tags: t }); guiAnh(msg, msg.author.id); }
        else msg.reply("❌ Không tìm thấy sự kết hợp này!");
    }

    // 9. !r34vid - Phim
    if (cmd === '!r34vid') {
        const d = await layDataR34(args.slice(1).join(' ') + " video -gore");
        if (!d.length) return msg.reply("❌ Hết phim!");
        const menu = new ActionRowBuilder().addComponents(new StringSelectMenuBuilder().setCustomId('vid').setPlaceholder('🎬 Chọn phim...').addOptions(d.slice(0, 25).map(v => ({ label: `ID: ${v.id}`, value: v.file_url }))));
        msg.reply({ content: `📺 Phim cho: \`${args.slice(1).join(' ')}\``, components: [menu] });
    }

    // 10. !r34loop / 11. !stop
    if (cmd === '!r34loop') {
        const tag = args[1]; const phut = parseInt(args[2]) || 60;
        if (!tag || treoMay.has(msg.channel.id)) return msg.reply("Sai tag hoặc đang chạy!");
        msg.reply(`✅ Auto gửi \`${tag}\` mỗi ${phut} phút.`);
        treoMay.set(msg.channel.id, setInterval(async () => { const data = await layDataR34(`${tag} -gore`, Math.floor(Math.random()*10), 1); if (data.length) msg.channel.send(data[0].file_url); }, phut * 60000));
    }
    if (cmd === '!stop') { clearInterval(treoMay.get(msg.channel.id)); treoMay.delete(msg.channel.id); return msg.reply("🛑 Đã dừng!"); }

    // 12. !r34tag / 13. !r34dl / 14. !r34user / 15. !r34sauce
    if (cmd === '!r34tag') msg.reply(`🏷️ Tag \`${args[1]}\` đang cực hot trên kho!`);
    if (cmd === '!r34dl') { const data = await layDataR34(`id:${args[1]}`); msg.reply(data.length ? `🔗 Link tải: ${data[0].file_url}` : "Sai ID!"); }
    if (cmd === '!r34user') { const data = await layDataR34(`user:${args[1]} -gore`); if (data.length) { boNhoTam.set(msg.author.id, { data, index: 0, tags: args[1] }); guiAnh(msg, msg.author.id); } }
    if (cmd === '!r34sauce') { const data = await layDataR34(`id:${args[1]}`); msg.reply(data.length ? `🕵️ Tags: \`${data[0].tags}\`` : "ID ảo!"); }

    // 16. !profile / 17. !rank
    if (cmd === '!profile') msg.reply(`📊 **Dân chơi:** ${msg.author.username}\n- Level: \`${stats.level}\`\n- XP: \`${stats.xp}\``);
    if (cmd === '!rank') msg.reply(`🏆 Hạng của ông giáo là: **Sơ cấp dân chơi** (Level ${stats.level})`);

    // 18. !r34daily - Quà hằng ngày
    if (cmd === '!r34daily') {
        const now = Date.now();
        if (now - stats.daily < 86400000) return msg.reply("Mai quay lại nhận tiếp ông giáo ơi!");
        stats.daily = now; stats.xp += 100;
        msg.reply("🎁 Chúc mừng! Ông giáo nhận được 100 XP 'hồi sức'.");
    }

    // 19. !r34best [năm]
    if (cmd === '!r34best') {
        const res = await aiModel.generateContent(`Gợi ý các tag Rule34 nổi nhất năm ${args[1] || '2025'}. Trả lời bỗ bã.`);
        msg.reply(`🌟 **Hàng tuyển năm ${args[1] || '2025'}:**\n${res.response.text()}`);
    }

    // 20. !clean - Dọn dẹp (Cần quyền Manage Messages)
    if (cmd === '!clean') {
        if (!msg.member.permissions.has(PermissionsBitField.Flags.ManageMessages)) return msg.reply("Ông không có quyền dọn rác!");
        await msg.channel.bulkDelete(50, true);
        msg.channel.send("🧹 Đã dọn dẹp hiện trường sạch sẽ!").then(m => setTimeout(() => m.delete(), 3000));
    }

    // !suggest - Gợi ý thêm
    if (cmd === '!suggest') {
        const res = await aiModel.generateContent("Gợi ý 5 tag Rule34 cực cháy cho tôi.");
        msg.reply(`🤖 **Gợi ý:** ${res.response.text()}`);
    }
});

// --- TƯƠNG TÁC NÚT ---
bot.on('interactionCreate', async (i) => {
    if (i.isButton()) {
        const s = boNhoTam.get(i.user.id);
        if (!s) return i.reply({ content: "Hết hạn!", ephemeral: true });
        if (i.customId === 'prev') s.index = (s.index - 1 + s.data.length) % s.data.length;
        if (i.customId === 'next') s.index = (s.index + 1) % s.data.length;
        if (i.customId === 'del') return i.message.delete();
        const { embed, row } = taoGiaoDien(s); await i.update({ embeds: [embed], components: [row] });
    }
    if (i.isStringSelectMenu()) await i.reply(`🎬 **Phim:**\n${i.values[0]}`);
});

// --- HELPERS ---
async function layDataR34(tag, p=0, lim=100) {
    const url = `https://api.rule34.xxx/index.php?page=dapi&s=post&q=index&limit=${lim}&pid=${p}&tags=${encodeURIComponent(tag + ' score:>10')}&json=1&user_id=${R34_CONFIG.uid}&api_key=${R34_CONFIG.key}`;
    try { const r = await axios.get(url); return r.data || []; } catch { return []; }
}

function taoGiaoDien(s) {
    const p = s.data[s.index];
    const link = p.file_url.startsWith('http') ? p.file_url : 'https:' + p.file_url;
    const embed = new EmbedBuilder().setTitle(`🌪️ Chaos Selection: ${s.tags}`).setImage(link.match(/\.(mp4|webm)$/i) ? p.preview_url : link)
        .addFields({name:'📊 ID',value:p.id.toString(),inline:true},{name:'⭐ Score',value:p.score.toString(),inline:true},{name:'📂',value:`${s.index+1}/${s.data.length}`,inline:true}).setColor('#3ae374');
    const row = new ActionRowBuilder().addComponents(
        new ButtonBuilder().setCustomId('prev').setEmoji('⬅️').setStyle(ButtonStyle.Success),
        new ButtonBuilder().setCustomId('next').setEmoji('➡️').setStyle(ButtonStyle.Success),
        new ButtonBuilder().setCustomId('del').setEmoji('🗑️').setStyle(ButtonStyle.Danger),
        new ButtonBuilder().setLabel('Link Gốc').setURL(link).setStyle(ButtonStyle.Link)
    );
    return { embed, row };
}

async function guiAnh(msg, uid) { const { embed, row } = taoGiaoDien(boNhoTam.get(uid)); await msg.reply({ embeds: [embed], components: [row] }); }

bot.login(TOKEN);
