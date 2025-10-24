document.addEventListener('DOMContentLoaded', () => {
    const emailInput = document.getElementById('current-email');
    const copyBtn = document.getElementById('copy-btn');
    const genEmailBtn = document.getElementById('gen-email-btn');
    const inboxList = document.getElementById('inbox-list');
    
    // Modal elements
    const modal = document.getElementById('email-content-modal');
    const closeModalBtn = document.querySelector('.close-btn');
    const emailSubject = document.getElementById('email-subject');
    const emailFrom = document.getElementById('email-from');
    const emailDate = document.getElementById('email-date');
    const emailBody = document.getElementById('email-body');

    let currentEmail = "";
    let inboxInterval;

    const API_URL = "https://www.1secmail.com/api/v1/";

    // Hàm tạo email ngẫu nhiên
    const generateNewEmail = async () => {
        // Ngừng kiểm tra email cũ (nếu có)
        if (inboxInterval) clearInterval(inboxInterval);
        inboxList.innerHTML = '<li>Đang tạo email mới...</li>';
        emailInput.value = "Đang tạo...";

        try {
            // API của 1secmail để tạo email ngẫu nhiên
            const response = await fetch(`${API_URL}?action=genRandomMailbox&count=1`);
            const data = await response.json();
            currentEmail = data[0];
            emailInput.value = currentEmail;
            
            // Bắt đầu kiểm tra hộp thư
            checkInbox();
            inboxInterval = setInterval(checkInbox, 5000); // Kiểm tra mỗi 5 giây
        } catch (error) {
            console.error("Lỗi khi tạo email:", error);
            emailInput.value = "Lỗi! Hãy thử lại.";
        }
    };

    // Hàm kiểm tra hộp thư đến
    const checkInbox = async () => {
        if (!currentEmail) return;

        try {
            const [login, domain] = currentEmail.split('@');
            const response = await fetch(`${API_URL}?action=getMessages&login=${login}&domain=${domain}`);
            const data = await response.json();

            inboxList.innerHTML = ''; // Xóa danh sách cũ
            if (data.length === 0) {
                inboxList.innerHTML = '<li>Chưa có email nào...</li>';
            } else {
                data.forEach(email => {
                    const li = document.createElement('li');
                    li.innerHTML = `<strong>Từ:</strong> ${email.from} <br> <strong>Tiêu đề:</strong> ${email.subject}`;
                    // Thêm data-id để biết bấm vào email nào
                    li.dataset.id = email.id;
                    li.dataset.login = login;
                    li.dataset.domain = domain;
                    inboxList.appendChild(li);
                });
            }
        } catch (error) {
            console.error("Lỗi khi kiểm tra inbox:", error);
        }
    };

    // Hàm xem nội dung email
    const readEmail = async (login, domain, id) => {
        try {
            const response = await fetch(`${API_URL}?action=readMessage&login=${login}&domain=${domain}&id=${id}`);
            const data = await response.json();

            emailSubject.textContent = data.subject;
            emailFrom.textContent = data.from;
            emailDate.textContent = data.date;
            // Hiển thị nội dung HTML của email
            emailBody.innerHTML = data.htmlBody || data.textBody; 
            
            modal.style.display = "block"; // Hiển thị modal
        } catch (error) {
            console.error("Lỗi khi đọc email:", error);
        }
    };

    // Sự kiện click
    genEmailBtn.addEventListener('click', generateNewEmail);

    copyBtn.addEventListener('click', () => {
        if (emailInput.value) {
            navigator.clipboard.writeText(emailInput.value)
                .then(() => {
                    copyBtn.textContent = 'Đã Copy!';
                    setTimeout(() => { copyBtn.textContent = 'Copy'; }, 2000);
                })
                .catch(err => console.error('Không thể copy:', err));
        }
    });

    // Sự kiện click vào 1 email trong danh sách
    inboxList.addEventListener('click', (e) => {
        const emailItem = e.target.closest('li');
        if (emailItem && emailItem.dataset.id) {
            const { id, login, domain } = emailItem.dataset;
            readEmail(login, domain, id);
        }
    });

    // Đóng Modal
    closeModalBtn.addEventListener('click', () => {
        modal.style.display = "none";
    });

    window.addEventListener('click', (e) => {
        if (e.target == modal) {
            modal.style.display = "none";
        }
    });

    // Tự động tạo email khi tải trang
    generateNewEmail();
});
