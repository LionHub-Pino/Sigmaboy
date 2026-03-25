import os
import time
import requests
import random
import sys

# ======================================================
# --- CẤU HÌNH (THAY LINK WORKER CỦA ÔNG TẠI ĐÂY) ---
# ======================================================
API_URL = "https://shoukosetup.binhgoldtt1.workers.dev" 
PYTHON_PATH = "/data/data/com.termux/files/usr/bin/python"
WORKING_DIR = "/sdcard/Download"

def check_api():
    """Kiểm tra xem link Worker có hoạt động không"""
    try:
        # Thử gửi một request check đơn giản
        r = requests.get(f"{API_URL}/check?code=ping", timeout=5)
        return True
    except:
        return False

def execute_tool(data):
    """Thực thi tool Shouko với thông số từ Web"""
    print("\n" + "—"*45)
    print(f"Run Config: {data.get('cfg', 'Manual_Run')}")
    print(f"🆔 ID: {data.get('id')}")
    
    key = data.get('k', '')
    game_id = data.get('id', '')
    
    # Chuỗi nhập liệu tự động (Luồng của ông)
    inputs = f"{key}\\n2\\n1\\n0\\n{game_id}\\n\\n1\\n10"
    
    # Lệnh Root
    cmd = f"su -c 'export PATH=$PATH:/data/data/com.termux/files/usr/bin && cd {WORKING_DIR} && (echo -e \"{inputs}\"; cat) | {PYTHON_PATH} shouko.py'"
    
    print("—"*45)
    os.system(cmd)

def main():
    while True:
        os.system("clear")
        is_online = check_api()
        status_text = "\033[92m[ KẾT NỐI OK ]\033[0m" if is_online else "\033[91m[ LỖI API - CHECK LINK ]\033[0m"
        
        print("—"*45)
        print("      🌟 SHOUKO SET UP 🌟")
        print(f"      Trạng thái API: {status_text}")
        print("—"*45)
        print(" [1] Nhận mã PIN Điền Config")
        print(" [2] Chạy từ Config Web đã lưu")
        print(" [3] Thoát")
        print("—"*45)
        
        if not is_online:
            print("\n⚠️  Cảnh báo: Link API_URL có vẻ sai hoặc server sập.")
            print("👉 Hãy kiểm tra lại dòng API_URL trong file .py")

        choice = input("\n Nhập lựa chọn (1-3): ")

        if choice == "1":
            if not is_online:
                print("❌ API Lỗi, không thể tạo mã PIN!"); time.sleep(2); continue
                
            num_part = random.randint(100000, 999999)
            pin = f"60_{num_part}"
            
            print(f"\n🔑 MÃ PIN CỦA ÔNG: \033[93m{pin}\033[0m")
            print("👉 Nhập mã này vào Web để bắn lệnh xuống.")
            
            while True:
                try:
                    r = requests.get(f"{API_URL}/check?code={pin}", timeout=5)
                    if r.status_code == 200:
                        data = r.json()
                        if data.get("status") != "not_found":
                            execute_tool(data)
                            break
                except:
                    pass
                time.sleep(3)

        elif choice == "2":
            name = input("\n Nhập tên Config (KV Name): ")
            try:
                r = requests.get(f"{API_URL}/check?code=cfg_{name}", timeout=5)
                if r.status_code == 200:
                    data = r.json()
                    if data.get("status") != "not_found":
                        execute_tool(data)
                    else:
                        print(f"❌ Không tìm thấy Config '{name}'!"); time.sleep(2)
            except:
                print("❌ Lỗi kết nối!"); time.sleep(2)

        elif choice == "3":
            sys.exit()

if __name__ == "__main__":
    main()
