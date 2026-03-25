import os
import time
import requests
import threading
import platform
import socket
import random

# ======================================================
# --- CẤU HÌNH (THAY LINK WORKER CỦA ÔNG TẠI ĐÂY) ---
# ======================================================
API_URL = "https://shoukosetup.binhgoldtt1.workers.dev"
PYTHON_PATH = "/data/data/com.termux/files/usr/bin/python"
WORKING_DIR = "/sdcard/Download"

# Tự động lấy tên máy để hiện lên Dashboard
def get_dev_name():
    try:
        name = socket.gethostname()
        if "localhost" in name or not name:
            return "Mobile_" + str(random.randint(100, 999))
        return name
    except: return "Android_User"

DEVICE_NAME = get_dev_name()

# ======================================================
# --- HỆ THỐNG THEO DÕI (MONITOR) ---
# ======================================================
def get_sys_stats():
    try:
        # Đọc RAM chuẩn xác
        with open('/proc/meminfo', 'r') as f:
            m = {l.split(':')[0].strip(): int(l.split(':')[1].split()[0]) for l in f if ':' in l}
        total = m.get('MemTotal', 1)
        avail = m.get('MemAvailable', m.get('MemFree', 0))
        ram = int(((total - avail) / total) * 100)

        # Đọc CPU Delta (Đo trong 0.5s)
        def read_cpu():
            with open('/proc/stat', 'r') as f:
                fields = [int(x) for x in f.readline().split()[1:]]
                return sum(fields), fields[3]
        
        t1, i1 = read_cpu()
        time.sleep(0.5)
        t2, i2 = read_cpu()
        cpu = int(((t2-t1) - (i2-i1)) / (t2-t1) * 100) if (t2-t1) > 0 else 0
        
        return max(0, min(100, cpu)), max(0, min(100, ram))
    except:
        return random.randint(5, 12), 45

def monitor_thread():
    while True:
        try:
            c, r = get_sys_stats()
            payload = {
                "id": DEVICE_NAME,
                "cpu": c,
                "ram": r,
                "log": f"Active | Server: SG | {time.strftime('%H:%M:%S')}"
            }
            requests.post(f"{API_URL}/update_status", json=payload, timeout=5)
        except: pass
        time.sleep(10) # Cập nhật Web sau mỗi 10 giây

threading.Thread(target=monitor_thread, daemon=True).start()

# ======================================================
# --- LOGIC CHẠY TOOL (SHOUKO) ---
# ======================================================
def start_shouko(data):
    print("\n" + "="*40)
    print(f"[+] NHẬN LỆNH TỪ WEB: {data.get('cfg', 'Manual')}")
    
    key = data.get('k', '')
    game_id = data.get('id', '')
    
    # Chuỗi nhập liệu tự động (Dựa trên bản Shouko cũ của ông)
    # Key -> Menu 2 -> Tab 1 -> Back 0 -> ID Game -> Run 1 -> Time 10
    inputs = f"{key}\\n2\\n1\\n0\\n{game_id}\\n\\n1\\n10"
    
    # Lệnh Root chuẩn
    cmd = f"su -c 'export PATH=$PATH:/data/data/com.termux/files/usr/bin && cd {WORKING_DIR} && (echo -e \"{inputs}\"; cat) | {PYTHON_PATH} shouko.py'"
    
    print(f"[*] Đang thực thi Tool cho ID: {game_id}...")
    os.system(cmd)

# ======================================================
# --- MENU CHÍNH ---
# ======================================================
def main_menu():
    os.system("clear")
    print("====================================")
    print("      SHOUKO CONTROL CENTER v3.6    ")
    print("====================================")
    print(f" DEVICE : {DEVICE_NAME}")
    print(f" STATUS : Monitoring Online...")
    print("------------------------------------")
    print(" 1. Nhận mã kết nối (Mã 4 số)")
    print(" 2. Chạy Config cũ (Nhập tên)")
    print(" 3. Thoát")
    
    choice = input("\n Chọn (1/2/3): ")

    if choice == "1":
        # Tạo mã 4 số ngẫu nhiên cho Tab SETUP trên Web
        code = str(random.randint(10000, 99999))
        try:
            # Gửi mã tạm lên Worker (để Web có thể tìm thấy)
            print(f"\n[!] MÃ KẾT NỐI: {code}")
            print("[*] Vui lòng nhập mã này vào Tab SETUP trên Web.")
            
            while True:
                # Kiểm tra xem ông đã nhấn 'Update & Run' trên Web chưa
                r = requests.get(f"{API_URL}/check?code={code}", timeout=5)
                if r.status_code == 200:
                    res = r.json()
                    if res.get("status") == "ready":
                        start_shouko(res)
                        break
                time.sleep(3)
        except:
            print("❌ Lỗi kết nối server!")

    elif choice == "2":
        name = input("\n Nhập tên Config đã lưu (VD: 123): ")
        try:
            # Kiểm tra Config đã lưu vĩnh viễn (prefix: cfg_)
            r = requests.get(f"{API_URL}/check?code=cfg_{name}", timeout=5)
            if r.status_code == 200:
                res = r.json()
                if res.get("status") == "ready":
                    start_shouko(res)
                else:
                    print(f"❌ Config '{name}' không tồn tại!")
            else:
                print("❌ Không tìm thấy dữ liệu!")
        except:
            print("❌ Lỗi kết nối!")

    elif choice == "3":
        print(" Đang thoát...")
        exit()

    input("\n Nhấn Enter để quay lại...")
    main_menu()

if __name__ == "__main__":
    main_menu()
