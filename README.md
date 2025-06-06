# 🏚️ MASTERNSLAVES - 내 돈 지켜(가제)



<br>
<h2>👥 팀원 소개</h2>
<table>
  <tr>
    <td align="center">
      <img src="images/keondong.jpeg" width="150"/>
    </td>
    <td align="center">
      <img src="images/chanjin.png" width="150"/>
    </td>
    <td align="center">
      <img src="images/jinho.png" width="150"/>
    </td>
    <td align="center">
      <img src="images/wooyoung.png" width="150"/>
    </td>
  </tr>
    <tr>
    <td align="center"> 김건동</td>
    <td align="center"> 김찬진</td>
    <td align="center">김진호</td>
    <td align="center"> 이우영 </td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/astraglus03" target="_blank"><img src="https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white"/></a>
    </td>
    <td align="center"><a href="https://github.com/Chanjin629" target="_blank"><img src="https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white"/></a>
    </td>
    <td align="center"><a href="https://github.com/jinnn12" target="_blank"><img src="https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white"/></a> 
    </td>
    <td align="center"><a href="https://github.com/ggj0228" target="_blank"><img src="https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white"/></a>
    </td>
  </tr>
</table>

<br>

## 🎬🎞️ 프로젝트 개요

<h3>01_프로젝트 주제</h3>



<h3>02_프로젝트 소개</h3>



<h3>03_프로젝트 필요성</h3>





<h3>04_프로젝트 주요 기능</h3>



<h3>05_서비스 차별화 전략</h3>


<br>

## ⚙️🛠️ Technical Stack

<h2>DB</h2>

<a href="https://mariadb.org" target="_blank">
  <img src="https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white"/>
</a>

<h2>Tool</h2>

<div><img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"/>
<img src="https://img.shields.io/badge/ERD%20cloud-0000FF?style=for-the-badge&logo=data:image/svg+xml;base64,&logoColor=white"/>
<img src="https://img.shields.io/badge/Discord-%235865F2.svg?style=for-the-badge&logo=discord&logoColor=white"/>
  <img src= "https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white"/>
</div>

<br>

## 🗓️ WBS

<details>
  <summary>WBS 보기</summary>
</details>

[WBS]('')

<br>

## 🧾 요구사항 명세서

<details>
  <summary>요구사항 명세서 보기</summary>
</details>

[요구사항 명세서]('')

## 🧱 ERD

<details>
  <summary>ERD 보기</summary>
</details>

[ERD]('')

<br>

## 🧾 DDL
<details>
  <summary>회원 관련</summary>
  <details>
  <summary>1. 회원 테이블 생성하기</summary>

  ```sql
CREATE TABLE user (
    user_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) DEFAULT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    type ENUM('user', 'admin') NOT NULL DEFAULT 'user',
    PRIMARY KEY (user_id)
);
  ```
  </details>
  
</details>

<hr>


## 🧾 DML

<details>
  <summary>회원 관련</summary>

```sql
-- 예시

```
</details>

<hr>

## ⏳⏰ 테스트케이스 코드 및 실행

<details>
  <summary>회원 정보 관리</summary>
  <details>
    <summary>1. 회원 가입</summary>
  </details>
    <details>
    <summary>2. 회원 탈퇴</summary>
  </details>
    <details>
    <summary>3. 회원정보 수정</summary>
  </details>
    <details>
    <summary>4. 회원정보 조회</summary>
  </details>
</details>   

<hr>

<details>
  <summary>관리자 정보 관리</summary>
  <details>
    <summary>1. 관리자 가입</summary>
  </details>
    <details>
    <summary>2. 관리자 탈퇴</summary>
  </details>
    <details>
    <summary>3. 관리자 정보 수정</summary>
  </details>
    <details>
    <summary>4. 관리자 정보 조회</summary>
  </details>
</details>  

<hr>

<br>

## 📜 동료평가

| Name | <center>김건동</center> |
|:---:|:---|
| **김찬진** | 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 |
| **김진호** | 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 |
| **이우영** | 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 |

| Name | <center>김찬진</center> |
|:---:|:---|
| **김건동** | 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 |
| **김진호** | 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 |
| **이우영** | 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 |

| Name | <center>김진호</center> |
|:---:|:---|
| **김건동** | 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 |
| **김찬진** | 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 |
| **이우영** | 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 |

| Name | <center>이우영</center> |
|:---:|:---|
| **김건동** | 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 |
| **김찬진** | 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 |
| **김진호** | 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 야무지게 잘하시네요 |








