let emailAddress = "";
let cookie = "";
let remaining = 600;
let timerInterval = null;

async function createEmail() {
  const res = await fetch("https://10minutemail.net/");
  const html = await res.text();
  cookie = res.headers.get("set-cookie") || "";

  const match = html.match(/class="mailtext" value="(.*?)"/);
  if (match) {
    emailAddress = match[1];
    document.getElementById("email-address").textContent = emailAddress;
    remaining = 600;
    startTimer();
    fetchMails(); // fetch initial
  } else {
    document.getElementById("email-address").textContent = "❌ Không thể tạo email";
  }
}

function startTimer() {
  clearInterval(timerInterval);
  timerInterval = setInterval(() => {
    remaining--;
    if (remaining <= 0) {
      clearInterval(timerInterval);
      document.getElementById("timer").textContent = "⏰ Hết hạn";
      return;
    }
    const mins = Math.floor(remaining / 60);
    const secs = remaining % 60;
    document.getElementById("timer").textContent = `⏳ Còn lại: ${mins} phút ${secs} giây`;
  }, 1000);
}

async function fetchMails() {
  try {
    const res = await fetch("https://10minutemail.net/mailbox.ajax.php", {
      headers: { Cookie: cookie }
    });
    const html = await res.text();
    const parser = new DOMParser();
    const doc = parser.parseFromString(html, "text/html");
    const rows = doc.querySelectorAll("tr");
    const container = document.getElementById("emails");
    container.innerHTML = "";

    rows.forEach(r => {
      const cols = r.querySelectorAll("td");
      if (cols.length >= 3) {
        const sender = cols[0].innerText.trim();
        const subject = cols[1].innerText.trim();
        const date = cols[2].innerText.trim();
        const link = "https://10minutemail.net/" + cols[1].querySelector("a")?.getAttribute("href");
        const mailEl = document.createElement("div");
        mailEl.className = "mail";
        mailEl.innerHTML = `
          <h3>${subject}</h3>
          <p><b>Từ:</b> ${sender}</p>
          <p><b>Ngày:</b> ${date}</p>
          <p><a href="${link}" target="_blank">Xem nội dung ➜</a></p>
        `;
        container.appendChild(mailEl);
      }
    });
  } catch (err) {
    console.error("Lỗi fetch mail:", err);
  }
}

// refresh mail mỗi 10s
setInterval(fetchMails, 10000);
document.getElementById("new-email").addEventListener("click", createEmail);

// khởi tạo
createEmail();
