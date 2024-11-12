<p align="center">
  <a href="https://www.uit.edu.vn/" title="Trường Đại học Công nghệ Thông tin" style="border: 5;">
    <img src="https://i.imgur.com/WmMnSRt.png" alt="Trường Đại học Công nghệ Thông tin | University of Information Technology">
  </a>
</p>

<!-- Title -->
<h1 align="center"><b>NT548.P11 - Công nghệ DevOps và ứng dụng</b></h1>

## BẢNG MỤC LỤC

- [ Giới thiệu môn học](#gioithieumonhoc)
- [ Giảng viên hướng dẫn](#giangvien)
- [ Thành viên nhóm](#thanhvien)
- [ Hướng dẫn chạy](#huongdan)

## GIỚI THIỆU MÔN HỌC

<a name="gioithieumonhoc"></a>

- **Tên môn học**: Công nghệ DevOps và ứng dụng
- **Mã môn học**: NT548.P11
- **Năm học**: 2024-2025

## GIẢNG VIÊN HƯỚNG DẪN

<a name="giangvien"></a>

- Ths **Lê Thanh Tuấn**

## THÀNH VIÊN NHÓM

<a name="thanhvien"></a>
| STT | MSSV | Họ và Tên | Github | Email |
| ------ |:-------------:| ----------------------:|-----------------------------------------------------:|-------------------------:
| 1 | 22520914 | Nguyễn Hải Nam |[NamSee04](https://github.com/NamSee04) |22520914@gm.uit.edu.vn |
| 2 | 22520673 | Lê Hữu Khoa |[kevdn](https://github.com/kevdn) |22520673@gm.uit.edu.vn |
| 3 | 22520864 | Làu Trường Minh |[LiuChangMinh88](https://github.com/LiuChangMing88) |22520864@gm.uit.edu.vn |

## HƯỚNG DẪN CHẠY
<a name="huongdan"></a>
- Để chạy terraform ta cần quyền truy cập vào server AWS.
- Để tạo instance trong public và private subnet, ta cần ami_id của instance tương ứng.

#### Ta thực hiện các bước sau:

#### 1. Cấu hình AWS credentials key:

```
[default]
aws_access_key_id=<your-key>
aws_secret_access_key=<your-key>
```

#### 2. Lấy public/private amd_id từ server AWS:

- Ta truy cập vào server AWS -> vào phần EC2 -> AMI Images. Sau đó, ta lấy tương ứng AMI ID của 1 public image và 1 private image rồi paste vào public_instance_ami và private_instance_ami trong ./main.tf

#### 3. Chạy checkov:

- Ta chạy những dòng lệnh sau:

```
checkov -b /folder_name
```

Đảm bảo pass checkov test

#### 4. Triển khai:

- Ta chạy những dòng lệnh sau để áp dụng auto-approve:

```
terraform init
terraform apply -auto-approve
```

Sau khi chạy xong, ta destroy để tiết kiệm tài nguyên:

```
terraform destroy
```
#### 5. push code lên github để tự động chạy với github action đã được cấu hình.