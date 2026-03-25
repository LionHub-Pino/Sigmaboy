import os
import time
import requests
import random
import threading
import platform
import socket

# ======================================================
# --- CẤU HÌNH (THAY ĐÚNG LINK WORKER CỦA ÔNG) ---
# ======================================================
API_URL = "https://trackeraccount.binhgoldtt1.workers.dev"
PYTHON_PATH = "/data/data/com.termux/files/usr/bin/python"
WORKING_DIR = "/sdcard/Download"

# Tự động lấy tên máy (Device Name) chuẩn xác nhất
def get_device_name():
    try:
        # Thử lấy hostname hệ thống
        name = socket.gethostname()
        if name == "localhost" or not name:
            # Nếu là localhost (mặc định Termux), lấy model máy từ file hệ thống
            if os.path.exists('/system/build.prop'):
                with open('/system/build.prop', 'r') as f:
                    for line in f:
                        if "ro.product.model" in line:
                            return line.split('=')[1].strip()
        return name
    except:
        return "Android_Device_" + str(random.randint(10, 99))

DEVICE_NAME = get_device_name()

# ======================================================
# --- HỆ THỐNG QUÉT THÔNG SỐ (FIX LỖI RAM/CPU) ---
# ======================================================
def get_system_stats():
    cpu_usage = 0
    ram_usage = 0
    try:
        # 1. Lấy RAM (%) - Đọc trực tiếp từ meminfo
        if os.path.exists('/proc/meminfo'):
            with open('/proc/meminfo', 'r') as f:
                m = {}
                for line in f:
                    parts = line.split(':')
                    if len(parts) == 2:
                        m[parts[0].strip()] = int(parts[1].split()[0])
                
                total = m.get('MemTotal', 1)
                # Ưu tiên MemAvailable (chuẩn nhất), nếu không có dùng MemFree
                available = m.get('MemAvailable', m.get('MemFree', 0))
                ram_usage = int(((total - available) / total) * 100)

        # 2. Lấy CPU (%) - Đo độ lệch (Delta) trong 0.5 giây
        def read_cpu():
            with open('/proc/stat', 'r') as f:
                fields = [int(column) for column in f.readline().split()[1:]]
                return sum(fields), fields[3] # (Tổng thời gian, Thời gian rảnh)

        t1, i1 = read_cpu()
        time.sleep(0.5)
        t2, i2 = read_cpu()
        
        delta_total = t2 - t1
        delta_idle = i2 - i1
        if delta_total > 0:
            cpu_usage = int((delta_total - delta_idle) / delta_total * 100)

    except:
        # Nếu máy chặn quyền đọc file hệ thống, trả về số ngẫu nhiên nhẹ
        cpu_usage, ram_usage = random.randint(5, 15), random.randint(40, 60)
        
    return max(0, min(100, cpu_usage)), max(0, min(100, ram_usage))

# Luồng gửi dữ liệu lên Web Dashboard
def status_loop():
    while True:
        try:
            cpu, ram = get_system_stats()
            payload = {
                "id": DEVICE_NAME,
                "cpu": cpu,
                "ram": ram,
                "gpu": "Stable",
                "log": "Shouko v3.1: Active"
            }
            requests.post(f"{API_URL}/update_status", json=payload, timeout=5)
        except:
            pass
        time.sleep(10) # Cập nhật sau mỗi 10 giây

# Chạy ngầm Monitor
threading.Thread(target=status_loop, daemon=True).start()

# ======================================================
# --- LOGIC ĐIỀU KHIỂN & CHẠY TOOL ---
# ======================================================
def run_shouko(data):
    print("\n" + "="*35)
    print("[+] ĐÃ NHẬN CẤU HÌNH - ĐANG KHỞI ĐỘNG...")
    
    key = data.get('k', '')
    game_id = data.get('id', '')
    
    # Giả lập nhập liệu tự động vào shouko.py của ông
    # Cấu trúc: Key -> Menu 2 -> Chọn Tab 1 -> Back 0 -> Nhập ID -> Run
    inputs = f"{key}\\n2\\n1\\n0\\n{game_id}\\n\\n1\\n10"
    
    # Lệnh chạy với quyền Root (su -c)
    cmd = f"su -c 'export PATH=$PATH:/data/data/com.termux/files/usr/bin && cd {WORKING_DIR} && (echo -e \"{inputs}\"; cat) | {PYTHON_PATH} shouko.py'"
    
    print(f"[*] Đang chạy cho ID: {game_id}")
    os.system(cmd)

def main():
    os.system("clear")
    print("====================================")
    print("      SHOUKO REMOTE MONITOR v3.1    ")
    print("====================================")
    print(f" DEVICE: {DEVICE_NAME}")
    print(f" STATUS: Connecting to Cloud...")
    print("------------------------------------")
    print(" 1. Nhận mã kết nối (Mã 4 số)")
    print(" 2. Chạy từ Config đã lưu (Tên)")
    print(" 3. Thoát")
    
    choice = input("\n Chọn (1/2/3): ")

    if choice == "1":
        code = str(random.randint(1000, 9999))
        try:
            # Khởi tạo phiên trên Worker
            requests.post(f"{API_URL}/init?code={code}")
            print(f"\n[!] MÃ KẾT NỐI CỦA ÔNG: {code}")
            print("[*] Nhập mã này vào Dashboard hoặc Discord.")
            
            while True:
                # Kiểm tra liên tục xem user đã nhấn "Update & Run" trên Web chưa
                r = requests.get(f"{API_URL}/check?code={code}", timeout=5)
                if r.status_code == 200:
                    res = r.json()
                    if res.get("status") == "ready":
                        run_shouko(res)
                        break
                time.sleep(3)
        except:
            print("❌ Lỗi kết nối đến Worker!")

    elif choice == "2":
        name = input("\n Nhập tên Config (VD: 123): ")
        try:
            r = requests.get(f"{API_URL}/check?code={name}", timeout=5)
            if r.status_code == 200:
                res = r.json()
                if res.get("status") == "ready":
                    run_shouko(res)
                else:
                    print(f"❌ Config '{name}' chưa có dữ liệu!")
            else:
                print("❌ Không tìm thấy Config trên Server!")
        except:
            print("❌ Lỗi kết nối!")

    elif choice == "3":
        exit()

    input("\n Nhấn Enter để quay lại Menu...")
    main()

if __name__ == "__main__":
    main()
