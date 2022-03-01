-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        8.0.27 - MySQL Community Server - GPL
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- idenit 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `idenit` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `idenit`;

-- 테이블 idenit.admin 구조 내보내기
CREATE TABLE IF NOT EXISTS `admin` (
  `admin_no` bigint NOT NULL AUTO_INCREMENT COMMENT '번호',
  `admin_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '관리자 아이디',
  `admin_pw` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '관리자 비밀번호',
  `regDt` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDt` timestamp NULL DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`admin_no`),
  UNIQUE KEY `admin_id` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='관리자';

-- 테이블 데이터 idenit.admin:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` (`admin_no`, `admin_id`, `admin_pw`, `regDt`, `modDt`) VALUES
	(1, 'admin', 'qweqwe123', '2021-10-28 18:34:45', NULL);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;

-- 테이블 idenit.allim 구조 내보내기
CREATE TABLE IF NOT EXISTS `allim` (
  `no` bigint NOT NULL AUTO_INCREMENT COMMENT '번호',
  `m_no` bigint NOT NULL COMMENT '회원번호',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '제목',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_gener0al_ci COMMENT '내용',
  `read` tinyint DEFAULT '0' COMMENT '0: 링크이동 1:읽기 전용',
  `href` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '링크',
  `regDt` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  PRIMARY KEY (`no`),
  KEY `FK_allim_member` (`m_no`),
  CONSTRAINT `FK_allim_member` FOREIGN KEY (`m_no`) REFERENCES `member` (`m_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='알림';

-- 테이블 데이터 idenit.allim:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `allim` DISABLE KEYS */;
/*!40000 ALTER TABLE `allim` ENABLE KEYS */;

-- 테이블 idenit.attend 구조 내보내기
CREATE TABLE IF NOT EXISTS `attend` (
  `no` bigint NOT NULL AUTO_INCREMENT COMMENT '번호',
  `b_no` bigint NOT NULL COMMENT '게시판번호',
  `m_no` bigint NOT NULL COMMENT '회원번호',
  `m_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '회원이름',
  `m_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '회원이미지',
  `kind` tinyint DEFAULT '0' COMMENT '0:대기 1:참여',
  `regDt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  PRIMARY KEY (`no`),
  KEY `FK_attend_board` (`b_no`),
  KEY `FK_attend_member` (`m_no`),
  CONSTRAINT `FK_attend_board` FOREIGN KEY (`b_no`) REFERENCES `board` (`b_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_attend_member` FOREIGN KEY (`m_no`) REFERENCES `member` (`m_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='참석,대기 인원';

-- 테이블 데이터 idenit.attend:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `attend` DISABLE KEYS */;
INSERT INTO `attend` (`no`, `b_no`, `m_no`, `m_name`, `m_img`, `kind`, `regDt`) VALUES
	(51, 51, 69, '김혁', 'img_kakao.jpg', 1, '2021-12-21 12:00:52');
/*!40000 ALTER TABLE `attend` ENABLE KEYS */;

-- 테이블 idenit.banner 구조 내보내기
CREATE TABLE IF NOT EXISTS `banner` (
  `no` bigint NOT NULL AUTO_INCREMENT COMMENT '번호',
  `img1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '이미지1',
  `img2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '이미지2',
  `img3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '이미지3',
  `link1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '링크1',
  `link2` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '링크2',
  `link3` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '링크3',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='배너';

-- 테이블 데이터 idenit.banner:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `banner` DISABLE KEYS */;
INSERT INTO `banner` (`no`, `img1`, `img2`, `img3`, `link1`, `link2`, `link3`) VALUES
	(1, 'img_event_football.png', 'img_home_banner.png', 'img_home_banner.png', NULL, NULL, NULL);
/*!40000 ALTER TABLE `banner` ENABLE KEYS */;

-- 테이블 idenit.board 구조 내보내기
CREATE TABLE IF NOT EXISTS `board` (
  `b_no` bigint NOT NULL AUTO_INCREMENT COMMENT '번호',
  `b_kind` enum('행사','모임','미팅') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '게시판 종류',
  `b_m_no` bigint DEFAULT NULL COMMENT '회원번호(주최자)',
  `b_m_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '주최자아이디',
  `b_img1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '게시판이미지1',
  `b_img2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '게시판이미지2',
  `b_img3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '게시판이미지3',
  `b_img4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '게시판이미지4',
  `b_zipcode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '우편번호',
  `b_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '주소',
  `b_address_sub` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '상세주소',
  `b_address_X` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '경도',
  `b_address_Y` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '위도',
  `b_open_chatting_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '오픈채팅주소',
  `b_category` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '카테고리',
  `b_p_limit` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '인원수 제한',
  `b_p_count` int unsigned DEFAULT '0' COMMENT '참여한인원수',
  `b_p_w_count` int unsigned DEFAULT '0' COMMENT '대기인원수',
  `b_time` timestamp NOT NULL COMMENT '만나는 날짜',
  `b_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '게시판제목',
  `b_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '게시판내용',
  `b_rule` mediumtext COMMENT '게시판규칙',
  `b_deadline_fl` tinyint DEFAULT '0' COMMENT '0: 미마감, 1: 마감',
  `b_del_fl` tinyint DEFAULT '0' COMMENT '0: 미삭제, 1: 삭제',
  `b_state` tinyint DEFAULT '0' COMMENT '''0:일반 , 1: 블랙''',
  `b_r_count` int DEFAULT '0' COMMENT '경고횟수',
  `regDt` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDt` timestamp NULL DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`b_no`),
  KEY `FK_board_member` (`b_m_no`),
  CONSTRAINT `FK_board_member` FOREIGN KEY (`b_m_no`) REFERENCES `member` (`m_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='게시판';

-- 테이블 데이터 idenit.board:~14 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` (`b_no`, `b_kind`, `b_m_no`, `b_m_id`, `b_img1`, `b_img2`, `b_img3`, `b_img4`, `b_zipcode`, `b_address`, `b_address_sub`, `b_address_X`, `b_address_Y`, `b_open_chatting_url`, `b_category`, `b_p_limit`, `b_p_count`, `b_p_w_count`, `b_time`, `b_title`, `b_content`, `b_rule`, `b_deadline_fl`, `b_del_fl`, `b_state`, `b_r_count`, `regDt`, `modDt`) VALUES
	(51, '행사', NULL, 'admin', 'img_home_event01.jpg', '', '', '', NULL, '충남 아산시 배방읍 희망로 100', '천안역 1번출구', '36.8086053683452', '127.140623053462', '', '행사', '8', 0, 1, '2021-11-27 03:00:00', '걷기 프로젝트 함께 해요. 비대면 걷기 프로젝트 입니다.', '축구하실 분', '축구하실 분', 0, 0, 0, 0, '2021-11-19 01:20:28', NULL),
	(52, '행사', NULL, 'admin', 'img_home_event01.jpg', '', '', '', NULL, '충남 아산시 신창면 순천향로 22', '정문 앞', '36.7708481856343', '126.93320644766', '', '축제', '제한없음', 0, 0, '2021-11-28 04:00:00', '순천향대학교 축제', '축제합니다', '정문 앞쪽으로', 0, 0, 0, 0, '2021-11-19 01:22:39', NULL),
	(53, '행사', NULL, 'admin', 'img_home_event03.jpg', '', '', '', NULL, '충남 천안시 동남구 봉명동 49-2', '정문 앞', '36.8086053683452', '127.140623053462', '', '축제', '4', 0, 2, '2021-11-24 14:00:00', '툴립축제', '툴립축제', '툴립축제', 0, 0, 0, 0, '2021-11-19 01:24:03', NULL),
	(54, '행사', NULL, 'admin', 'img_home_event02.jpg', '', '', '', NULL, '충남 천안시 동남구 봉명로 53', '정문 앞', '36.8086053683452', '127.140623053462', '', '대학교', '제한없음', 0, 1, '2021-11-24 03:00:00', '천안고 축제', '천안고 축제', '천안고 축제', 0, 0, 0, 1, '2021-11-19 01:24:53', NULL),
	(59, '모임', 69, 'wgilooy97', 'img_kakao.jpg', '', '', '', NULL, '충남 아산시 배방읍 연화로 99', '1층', '37.51838997236707', '126.80735808186782', '', '일상', '4', 0, 0, '2021-12-22 02:40:00', '원종동', 'test', 'test', 0, 0, 0, 0, '2021-12-21 10:08:41', '2021-12-23 12:03:28'),
	(70, '모임', NULL, 'admin', 'img_detail_thumbnail.png', '', '', '', NULL, '경기 부천시 원종동 190-6', 'ㅂㅈㄷ', '37.52465814042467', '126.8174986294126', '', '커리어', '5', 0, 0, '2021-12-24 15:20:00', '원종동', 'ㅂㅈㄷ', 'ㅂㅈㄷ', 0, 0, 0, 0, '2021-12-21 20:55:06', NULL),
	(71, '모임', NULL, 'admin', 'img_detail_thumbnail.png', '', '', '', NULL, '경기 부천시 부산 190-6', 'ㅂㅈㄷ', '35.5492041146384', '129.23997473597154', '', '커리어', '5', 0, 0, '2021-12-24 15:20:00', '부산', 'ㅂㅈㄷ', 'ㅂㅈㄷ', 0, 0, 0, 0, '2021-12-21 20:55:06', NULL),
	(72, '모임', NULL, 'admin', 'img_detail_thumbnail.png', '', '', '', NULL, '경기 부천시 부산 190-6', 'ㅂㅈㄷ', '36.80400240870431', '127.21227117557385', '', '커리어', '5', 0, 0, '2021-12-24 15:20:00', '천안', 'ㅂㅈㄷ', 'ㅂㅈㄷ', 0, 0, 0, 0, '2021-12-21 20:55:06', NULL),
	(74, '모임', 69, 'qwe', 'img_home_meet01.png', NULL, NULL, NULL, NULL, '서울 강남구 신사동 537-5', '201', '37.5182113247444', '127.023178824605', '', '커리어', '3', 0, 0, '2021-12-23 01:00:00', 'ㅁㄴㅇㄴㅁㅇ', 'ㅂㅈㄷ', 'ㅂㅈㄷ', 0, 0, 0, 0, '2021-12-23 10:21:36', NULL),
	(75, '모임', 69, 'qwe', 'null', NULL, NULL, NULL, NULL, '경기 부천시 역곡로496번길 47', 'ㅂㅈㄷ', '37.5286953020416', '126.819598422534', 'ㅂㅈㄷ', '취미', '3', 0, 0, '2021-12-24 01:00:00', 'ㅂㅈㄷ', 'ㅂㅈㄷ', 'ㅂㅈㄷ', 1, 1, 0, 0, '2021-12-23 11:47:35', NULL),
	(76, '모임', 69, 'qwe', 'img_mypage_main.png', NULL, NULL, NULL, NULL, '경기 부천시 역곡로455번길 60', '130', '37.5258964891415', '126.812859533281', 'qwe', '커리어', '4', 0, 0, '2021-12-24 00:00:00', 'qwe', 'ㅂㅈㄷ', 'ㅂㅈㄷ', 0, 0, 0, 0, '2021-12-23 12:12:19', NULL),
	(77, '모임', NULL, 'admin', 'img_mypage_main.png', '', '', '', NULL, '경기 부천시 고강동 381-6', 'ㅂㅈㄷ', '', '', '', '일상', '6', 0, 0, '2021-12-23 00:00:00', '모임', 'ㅂㅈㄷ', 'ㅂㅈㄷ', 0, 0, 0, 0, '2021-12-23 12:40:30', NULL),
	(78, '행사', NULL, 'admin', 'img_home_meet01.png', '', '', '', NULL, '서울 성동구 용답동 249-1', 'qwe', '37.5625141742841', '127.057918538454', '', '공연', '4', 0, 0, '2021-11-30 20:00:00', 'ㅂㅈㄷ', 'qwe', 'wqe', 0, 0, 0, 0, '2021-12-23 12:41:37', NULL),
	(79, '모임', NULL, 'admin', 'img_detail_thumbnail.png', '', '', '', NULL, '서울 강남구 세곡동 603', 'wwww', '37.4665736362859', '127.095568119182', '', '일상', '3', 0, 0, '2021-11-30 00:00:00', 'ssssss', 'w', 'wwwwww', 0, 0, 0, 0, '2021-12-23 14:17:52', '2021-12-23 14:18:00');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;

-- 테이블 idenit.comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `comment` (
  `c_no` bigint NOT NULL AUTO_INCREMENT COMMENT '번호',
  `c_b_no` bigint NOT NULL COMMENT '게시판번호',
  `c_m_no` bigint NOT NULL COMMENT '회원 번호',
  `c_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '회원이름',
  `c_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '회원사진',
  `c_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '내용',
  `c_group` bigint DEFAULT NULL COMMENT '그룹번호 (대댓글을 위한 컬럼 부모컬럼(고유번호)기준으로 지정됨)',
  `c_parentFl` tinyint DEFAULT '0' COMMENT '관계 0:부모 1:자식',
  `c_del_fl` tinyint DEFAULT '0' COMMENT '0:미삭제, 1: 삭제',
  `regDt` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDt` timestamp NULL DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`c_no`),
  KEY `c_b_no` (`c_b_no`),
  KEY `FK_comment_member` (`c_m_no`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`c_b_no`) REFERENCES `board` (`b_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_comment_member` FOREIGN KEY (`c_m_no`) REFERENCES `member` (`m_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='댓글';

-- 테이블 데이터 idenit.comment:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;

-- 테이블 idenit.friend 구조 내보내기
CREATE TABLE IF NOT EXISTS `friend` (
  `f_no` bigint NOT NULL AUTO_INCREMENT COMMENT '번호',
  `m_no` bigint NOT NULL COMMENT '회원번호',
  `f_m_no` bigint NOT NULL COMMENT '친구번호',
  `f_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '친구 이름',
  `f_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '친구 이미지',
  `f_fl` tinyint DEFAULT '0' COMMENT '수락 여부 0: 미수락, 1: 수락',
  `regDt` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  PRIMARY KEY (`f_no`),
  KEY `m_no` (`m_no`),
  KEY `FK_friend_member` (`f_m_no`),
  CONSTRAINT `FK_friend_member` FOREIGN KEY (`f_m_no`) REFERENCES `member` (`m_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `friend_ibfk_1` FOREIGN KEY (`m_no`) REFERENCES `member` (`m_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='친구';

-- 테이블 데이터 idenit.friend:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `friend` DISABLE KEYS */;
/*!40000 ALTER TABLE `friend` ENABLE KEYS */;

-- 테이블 idenit.information 구조 내보내기
CREATE TABLE IF NOT EXISTS `information` (
  `i_no` bigint NOT NULL AUTO_INCREMENT COMMENT '번호',
  `i_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '작성자',
  `i_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '제목',
  `i_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '내용',
  `regDt` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDt` timestamp NULL DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`i_no`),
  KEY `i_id` (`i_id`),
  CONSTRAINT `information_ibfk_1` FOREIGN KEY (`i_id`) REFERENCES `admin` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='사이트 정보(ex)이용약관, 개인정보처리방침)';

-- 테이블 데이터 idenit.information:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `information` DISABLE KEYS */;
INSERT INTO `information` (`i_no`, `i_id`, `i_title`, `i_content`, `regDt`, `modDt`) VALUES
	(1, 'admin', '이용약관', '오드 서비스이용약관\r\n\r\n제1조(목적)\r\n오드 통합서비스이용약관은 회사가 다양한 맞춤 \r\n서비스를\r\n제공함에 있어, 회사와 회원 간의 권리, 의무 및 책\r\n임 사항 등 을 규정함을 목적으로 합니다.\r\n\r\n제2조(정의)\r\n1. "회사"란 서비스를 제공하는 주체를 말합니다. \r\n2. "서비스"란, 회사가 제공하는 모임, 글쓰기, 행\r\n사, 그 외 프로필 등 회사가 제공하는 서비스 일체\r\n를 말합니\r\n다. 서비스는 정보통신설비를 이용하여 재화 및 \r\n용역을 거래할 수 있도록 설정한 가상의 영업장을 \r\n포함합니\r\n다. 서비스는 각 서비스 내부에서 보여지는 게시\r\n물, 기능, 재화, 용역 등을 모두 포함하 며, 이와 관\r\n련된 사항\r\n과 정보 또한 모두 포함합니다. \r\n3. "블록"이란, 국내 주소체계를 기반으로 미리 지\r\n정된 지역 을 의미하며, 온라인 상에서 1:1 대화를 \r\n포함하여 \r\n회사가 제 공하는 서비스 내 게시물이 게재될 수 \r\n있는 모든 공간을 말합 니다. \r\n4. “오드 커뮤니티”란 회사가 운영하는 모든 “블\r\n록”공간들을 통칭하는 명칭입니다. \r\n5. "회원"이란, 회사가 제공하는 서비스에 접속하\r\n여 본 약관을 동의하고 가입 및 인증 후 서비스를 \r\n제공받는 \r\n자를 말합니다. 모든 서비스의 이용자는 대학생\r\n(대학교 재학중, 휴학 포함)의 범위로 제한합니다.\r\n6. “아이디"란, 회원의 식별과 서비스 이용을 위하\r\n여 회원이 정하고 회사가 승인하는 문자 또는 문\r\n자와 숫자\r\n의 조합을 의 미합니다. \r\n7. “프로필”이란 회원이 서비스 내에서 활동하기 \r\n위해 만든 임의의 프로필로, 관심사 정보\r\n와 직업에 대한 간략한 소개가 포함됩니다. \r\n8. "게시물"이란, 회원이 서비스를 이용함에 있어\r\n서비스에 게시한 모든부호·문자·음성·음향·화상·\r\n동영상 등의 \r\n정보 형태의 글, 사진, 동영상, 채팅 메시지 및 각\r\n종 파일과 링크 등을 의미합니다. \r\n9. "모임"란, 회사의 서비스를 통해 회원이 직접 \r\n만든 모임 으로 한 명 이상의 회원들과 모여 자유\r\n롭게 관심사\r\n를 공유하고 온 오프라인 상에서 친목을 도모할 \r\n수 있도록 회사가 제 공하는 서비스를 의미합니\r\n다.\r\n10. “친구추가”란 오드 커뮤니티에서 다른 유저에\r\n게 행할 수 있 는 동작 기능으로, ‘친구 유저 소식\r\n을 친구인 \r\n유저에게만 공개하는 모임\' 등 특수 기능을 이용\r\n할 수 있습니다. \r\n대방에게 게시물과 모임를 숨김하는 동시에 상대\r\n방의 게시물, 모임에 노출되지 않습니다.\r\n11. “모임 규칙” 이란 오드 커뮤니티 내에서 “모\r\n임”를 통해 다른 회원을 만날\r\n때 지켜야 하는 내부 규약입니다. \r\n12. “오픈채팅방링크”는 모임생성시 모임생성자\r\n가 카카오톡 등의 채팅방 링크를 기재합니다. 링\r\n크는 모임생\r\n성자가 승인한 참여자만 확인할 수 있습니다.\r\n13. “행사”란 운영진이 행사주최자에게 정보를 제\r\n공 또는 요청을 받아서 행사와 관련된 내용을 회\r\n원이 블록\r\n단위로 간편하게 확인할 수 있는 서비스를 말합니\r\n다.\r\n14. "약정"이란, 구매, 판매, 공급, 지급, 제작, 중\r\n개, 중계, 당첨 등 서비스 내부에서 회사와 회원 사\r\n이에 발생\r\n한 계약, 서약, 약속 등을 말합니다.\r\n\r\n제3조(약관의 게시와 개정)\r\n1. 회사는 회사의 모든 약관과 법령에 따라 명시해\r\n야 하는 정보가 있을 경우, 서비스 하단,\r\n더보기, 마이페이지, 그 외 기타 메뉴, 팝업, 배너 \r\n등에 게시할 수 있습니다. \r\n2. 회사는 관련법을 위배하지 않는 범위에서 본 약\r\n관을 개정 할 수 있습니다.\r\n3. 만약 개정내용이 회원에게 불리한 경우, 적용 \r\n일자 30일 이 전부터 적용 일자 전일까지 오드 앱 \r\n서비스 내\r\n에서 확인할 수 있는 공지사항에 공지합니다.\r\n4. 회사가 제2항에 따라 개정 약관을 공지한 후, \r\n회원이 30일 이내에 명시적으로 거부 의사 표시를 \r\n하지 않은 \r\n경우 회원이 개정 약관에 동의한 것으로 간주\r\n합니다. \r\n5. 회원이 개정약관의 적용에 동의하지 않는 경우, \r\n회원은 이용계약을 해지함으로써\r\n거부 의사를 표시할 수 있습니다. \r\n6. 회사는 유료 서비스 및 개별 서비스에 대해서는 \r\n별도의 이용약관 및 정책을 둘 수 있으며, 해당 내\r\n용이 이 \r\n약관과 상충할 경우 더 우선시 할 수 있습니다.\r\n7. 회원은 약관 일부분만을 동의 또는 거부할 수 \r\n없습니다. \r\n8. 본 약관의 일부가 집행 불능으로 판단되더라도 \r\n나머지 부분은 계속해서 효력을 갖습니다.\r\n\r\n제4조(서비스 이용 계약 등)\r\n1. 회원이 되고자 하는 자는 회사가 정한 가입 양\r\n식에 따라 회원정보를 입력하고 각 약관을\r\n동의한 후 동의 버튼을 누르는 방법으로 회원 가\r\n입을 신청합니다.\r\n2. 회원가입신청의 성립은 회사의 승낙이 가입 신\r\n청자에게 도달한 시점으로 합니다. \r\n3. 회사는 제1항과 같이 회원으로 가입할 것을 신\r\n청한 자에게 서비스 이용을 승낙함을 원칙으로 합\r\n니다. 다\r\n만, 다음 각호에 해당하는 경우, 별도의 통보 없이 \r\n회원가입을 거부하거나 이용 계약을 해지할 수 있\r\n습니다. \r\n-각 약관을 준수하지 않거나 각 약관에 의해 가입 \r\n신청자가 회원 자격을 상실한 적이 있을 경우 \r\n- 기타 회원으로 등록하는 것이 부적절하다고 판\r\n단되는 경우\r\n4. 회사는 부정사용방지 및 본인확인을 위해 제휴\r\n기관을 통한 실명확인 및 본인인증을 요청할 수 \r\n있습니다.\r\n5. 회사는 회원의 개인정보 및 서비스 이용 기록\r\n(위치인증, 학교 메일 인증 등)에 따\r\n라 서비스 이용에 차이를 둘 수 있습니다. \r\n6. 회사는 회원이 서비스를 이용하는 도중, 연속하\r\n여 1년 동안 서비스를 이용하기 위해 로그인 기록\r\n이 없는 \r\n경우 회원자격을 박탈할 수 있습니다.\r\n\r\n제5조(회원의 의무)\r\n1. 회원이 서비스를 이용하는 것은 회원이 적용 가\r\n능한 모든 법률, 규범 및 규정을 준수함에 동의하\r\n는 것입니\r\n다. 또한 회원 은 서비스 이용을 규정하는 특정 추\r\n가 규범(이하 행동 규범)을 준수함에 동의합니다. \r\n행동 규범\r\n은 모든 내용을 담고 있는 것 은 아니며, 회사는 특\r\n정 행동이 금지 목록에 있는지에 관계없 이 서비\r\n스의 완전\r\n함과 속성을 보호하기 위해 (회원에게 통지 하고) \r\n환불, 영구 정지를 포함한 적합한 징계조치를 취\r\n할 수 있음\r\n은 물론 언제라도 이 행동 규범을 수정할 권한을 \r\n보유합니다. 이러한 행동 규범 외에도, 모범적인 \r\n서비스 이용\r\n행동 및 제재조치들에 대한 자세한 안내는 서비스 \r\n내에 공지된 회원 규율 및 운영정책을 참고하십시\r\n오.\r\n다음은 제재 조치가 따르 는 행동의 예시를 나열\r\n한 것으로 이에 국한되지 않습니다. \r\n- 신청 또는 변경 시 허위 기재, 기재 누락, 오기, \r\n도용 행위 \r\n- 회사 및 제3자의 명예를 손상시키거나 업무를 방\r\n해하는 행\r\n- 회사의 모든 재산에 대한 침해 행위 \r\n- 회사의 서비스 이외의 허가하지 않은 행위 \r\n- 회사의 직원 또는 서비스 관리자를 사칭하는 행\r\n위 \r\n- 서비스 내 게시물 및 자료를 허가 없이 이용, 변\r\n조, 삭제 및 외부로 유출하는 행위 \r\n- 타인의 개인정보 및 계정을 수집, 저장, 공개, 이\r\n용하거나 자 신과 타인의 개인정보를 제3자에게 \r\n공개, 양도\r\n하는 행위 \r\n- 다중 계정을 생성 및 이용하는 행위 \r\n- 허가되지 않은 상업적 행위 \r\n- 통합개인정보보호약관 등 회원이 동의한 모든 \r\n약관에 대해 따르지 않는 행위 \r\n- 통합커뮤니티이용규칙에 어긋나는 행위\r\n- 현행법에 어긋나거나 서비스 제공에 있어 부적\r\n절하다고 판단되는 행위 \r\n2. 회사는 이용자가 본 조 제2항의 금지행위를 한 \r\n경우 본 약제 18조에 따라 서비스 이용 제한 조치\r\n를 취할 수 \r\n있습니다. \r\n3. 회원은 회원가입신청을 한 시점의 정보와 현재\r\n의 정보가 다를 경우 즉시 변경사항을 정정해야 \r\n합니다. \r\n4. 회사의 서비스 관련설비와 관련된 기술상 또는 \r\n업무상 문제 가 있는 경우에 승낙이 유보될 수 있\r\n습니다. \r\n5. 회사가 관계 법령 및 각 약관에 의해서 책임을 \r\n지는 경우를 제외하고, 자신의 개인정보에 관한 \r\n관리책임은 \r\n각 회원에게 있으므로, 부정 사용되지 않도록 관\r\n리해야 합니다. \r\n6. 회원은 아이디 및 비밀번호가 도용되거나 제3\r\n자가 사용하고 있음을 인지한 경우 이를 즉시 회\r\n사에 통지하\r\n고, 회사의 안 내에 따라야 합니다. \r\n7. 제4항의 경우에 해당 회원이 회사에 그 사실을 \r\n통지하지 않거나, 통지한 경우에도 회사의 안내에 \r\n따르지 \r\n않아 발생한 불이익에 대하여 회사는 책임지지 않\r\n습니다. \r\n8. 회사는 회원의 아이디가 개인정보 유출 우려가 \r\n있거나, 반 사회적 또는 미풍양속에 어긋나거나 \r\n회사 및 회\r\n사의 운영자로 오인될 우려가 있는 경우, 해당 아\r\n이디의 이용\r\n을 제한할 수 있습니다. \r\n9. 회원은 서비스를 이용함에 있어 회사의 각 약관\r\n을 준수하 지 않거나 의무를 다하지 않아 회사나 \r\n다른 회원\r\n이 손해를 입 을 경우, 그 손해를 배상할 책임이 있\r\n습니다.\r\n\r\n제6조 (회원정보의 변경)\r\n1. 회원은 서비스내 "마이페이지”를 통하여 언제\r\n든지 본인의 개인 정보를 열람하고 수정할 수 있\r\n습니다. 다\r\n만, 서비스 관리를 위 해 필요한 단말기 식별번호 \r\n(디바이스 아이디 또는 IMEI), 전화번호, 아이디\r\n(이메일 주\r\n소), 생년월일, 학교,학과 등은 수정이 불가능합니\r\n다. \r\n- 오류 또는 잘못된 오기입으로 인해 다른 정보를 \r\n입력한 경우 문의하기를 통해서 관리자가 승인을 \r\n통해 수정\r\n할 수 있습니다.\r\n2. 회사는 서비스 관련설비와 관련해 기술상 또는 \r\n업무상 문제로 프로필이 바로 변경되지 않을 수 \r\n있으며 이\r\n로 발생한 불이익에 대하여 회사는 책임지지 않습\r\n니다.\r\n\r\n제7조(회원에 대한 통지 등)\r\n1. 회사가 특정 회원에 대해 통지를 하는 경우, 회\r\n원의 개인정보와 서비스 내부 수단을 사용할 수 \r\n있습니다. \r\n2. 회원 전체에 대한 통지의 경우, 공지사항에 게\r\n시함으로써 제1항의 통지에 대신할 수 있습니다. \r\n3. 회원이 30일 이내에 의사 표시를 하지 않은 경\r\n우, 회원이 통지 내용에 대해 동의한 것으로 간주\r\n합니다.\r\n\r\n제8조(서비스 및 약정의 제공, 변경, 중단, 철회)\r\n1. 회사는 회사가 자체 개발하거나 다른 회사와의 \r\n협력을 통 해 회원들에게 제공할 일체의 서비스를 \r\n제공합니\r\n다. \r\n2. 회원은 서비스에서 제공하는 기능을 이용하여 \r\n재화 및 용 역을 구매하거나, 모임 등에 참여할 때, \r\n승인, 버\r\n튼을 누르는 방식 등으로 동의 의사를 표현하여 \r\n약정을 체결할 수 있습니다. \r\n3. 서비스를 이용하거나 약정을 체결할 경우, 서비\r\n스를 이용하거나 약정을 체결하기까지 명시된 모\r\n든 내용에 \r\n동의한 것으 로 봅니다.\r\n4. 서비스 변경 및 중단의 경우에는 제6조에서 정\r\n한 방법을 통해 통지합니다. 다만 회사가 통제할 \r\n수 없는 사\r\n유로 서비스 가 중단되어 통지가 불가능한 경우에\r\n는 통지하지 않습니다\r\n\r\n제9조(회사의 의무)\r\n1. 회사는 법령과 본 약관이 금지하거나 공서양속\r\n에 반하는 행위를 하지 않습니다. \r\n2. 회사는 안정적, 지속적이고 편리한 서비스를 제\r\n공하기 위 해 노력합니다.\r\n\r\n제10조(저작권의 귀속)\r\n1. 회사가 작성한 게시물에 대한 권리는 회사에게 \r\n귀속됩니다. 그러므로 회원은 서비스를 이용함으\r\n로써 얻은 \r\n정보를 회사의 사전 승낙 없이 임의로 복제, 전송, \r\n출판, 배포 등 영리 목적으로 이용하거나 제3자에\r\n게 제공할 \r\n수 없습니다. \r\n2. 회원이 작성한 게시물에 대한 권리는 회원에게 \r\n귀속됩니다. 단, 회사는 서비스의 운영, 확장, 홍보 \r\n등의 필\r\n요한 목적으로 회원의 저작물을 합리적이고 필요\r\n한 범위 내에서 별도의 허락 없이 수정하여 무상\r\n으로 사용하\r\n거나 제휴사에게 제공할수 있습니다. 이 경우, 개\r\n인정보는 절대 제공하지 않습니다. \r\n3. 회사는 제2항 이외의 방법으로 회원의 게시물\r\n을 이용할 경 우, 회원의 개인정보와 서비스 내부 \r\n수단을 이\r\n용하여 회원의 동의를 받아야 합니다.\r\n\r\n제11조(게시물 및 커뮤니티의 관리)\r\n1. 회원이 관련법 및 각 약관에 위배되는 내용의 \r\n커뮤니티를 개설하거나 게시물을 게시할 경우, 회\r\n사는 해당 \r\n서비스, 커뮤 니티 또는 게시물을 임의로 삭제, 중\r\n단, 변경 등의 조치를 할 수 있고 회원의 자격 및 \r\n권한을 제\r\n한, 정지 및 박탈할 수 있습 니다. \r\n2. 회원의 게시물로 인한 법률상 이익 침해를 근거\r\n로, 다른 회 원 또는 제3자가 회원 또는 회사를 대\r\n상으로 하\r\n여 민형사상의 법적 조치를 취하거나 관련된 게시\r\n물의 삭제를 요청하는 경 우, 회사는 관련 게시물\r\n에 대한 접\r\n근을 잠정적으로 제한할 수 있습니다.\r\n\r\n제12조 오드의 오드 앱 서비스 개별 커뮤니티 이\r\n용규칙\r\n1. 오드 커뮤니티는 회원이 직접 만들어가는 공간\r\n입니다. \r\n- 오드 커뮤니티는 회원분들의 자정능력을 존중합\r\n니다. 깨끗한 커뮤니티를 위해 노력해주시기 바랍\r\n니다. \r\n- 회원은 서로 예의를 지키고, 존중해야 합니다.\r\n2. 다음 목록에 해당하는 게시물의 게시, 댓글 작\r\n성, 모임 생성, 개설을 금지하고\r\n있습니다. \r\n- 욕설, 비아냥, 비속어 등 예의범절에 벗어난 게\r\n시물 \r\n- 혐오스럽거나 타 회원을 놀라게 하는 게시물 \r\n- 성적 비하를 포함하는 게시물 \r\n- 불건전한 만남, 대화, 통화 등을 목적으로 하는 \r\n게시물 \r\n- 특정인이나 단체/지역 등을 비방하는 게시물 \r\n- 중복글, 도배글, 낚시글, 내용 없는 게시물 \r\n- 익명을 악용한 여론 조작 \r\n- 관련법에 위배되거나, 타인의 권리를 침해하는 \r\n게시물(초상권, 저작권 등) \r\n- 허가되지 않은 광고/홍보물 또는 상업적 게시물\r\n(타 서비스 및 사이트, 공동구매, 홍보성 모임 등) \r\n- 논란 및 분란을 일으킬 수 있는 게시물 \r\n- 청소년유해매체물, 외설, 음란물, 음담패설, 신체\r\n사진 \r\n- 관리자를 사칭하는 게시물 \r\n- 기타 부적합한 게시물\r\n3. 다음 목록에 해당하는 규칙을 모두 지켜야 합니\r\n다. \r\n- 각종 게시판의 게시물, 모임 상세내용, 채팅방, \r\n복사, 스크린샷 등을 통해 절대 외부로 유출해서\r\n는 안됩니다.\r\n- 타인의 개인정보 및 계정을 수집, 저장, 공개, 이\r\n용하거나, 자신의 개인정보 및 계정을 공\r\n개, 공유해서는 안 됩니다. \r\n- 회원이 관련법 및 각 약관에 위배되는 내용의 게\r\n시판을 개설하거나 게시물을 게시할 경우, 삭제, \r\n중단, 변경 \r\n등의 제재가 가해질 수 있으며, 회원은 자격 및 권\r\n한을 제한, 정지, 박탈당 할 수 있습니다.\r\n4. 회원 및 게시물 신고 제도 \r\n- 커뮤니티 이용규칙에 어긋난다고 생각하는 게시\r\n물은 신고 버튼을 이용하여 신고해주시기 바랍니\r\n다. \r\n- 모든 신고는 자동신고시스템을 통해 회사가 검\r\n토한 후 처리됩니다. 회원의 요청에 따라 게시물\r\n을 삭제하지 \r\n않습니다. \r\n- 신고가 누적된 회원은 접근 제한 등의 제재가 가\r\n해질 수 있습니다. \r\n- 관리자는 해당유저가 다른 유저들로부터 받은 \r\n신고가 합당하다고 판단되고, 3회 이상 누적된 경\r\n우 계정 영\r\n구정지 등의 강력조치를 취할 수 있습니다.\r\n- 신고 제도를 악용할 경우, 해당 신고는 처리되지 \r\n않습니다. 신고 제도를 악용한 회원은 제재가 가\r\n해질 수 있\r\n습니다.\r\n- 모임 내 불건전한 발언 및 행동에 대해서 사실을 \r\n증명할 수 있는 자료를 같이 보내주셔야 해당 회\r\n원에 대해 \r\n제재가 주어집니다.\r\n5. 허위사실 유포 및 명예훼손 게시물에 대한 게시\r\n중단 요청 - 허위사실 유포 및 명예훼손 등 권리를 \r\n침해하는 \r\n게시물의 게시중단을 원하실 경우, 고객센터로 연\r\n락을 하셔서 게시중단 요청을 전달주시기 바랍니\r\n다. 연락은 \r\n934wkdgns@naver.com으로 가능합니다.\r\n- 게시중단 요청 시 사실을 증명할 수 있는 자료\r\n(스크린 샷 등) 를 같이 보내주셔야 합니다.\r\n- 게시중단 요청은 담당자를 통해 접수된 순서에 \r\n따라 처리됩 니다. \r\n- 허위사실 유포 및 명예 훼손에 해당하지 않는다\r\n고 판단되는 경우, 해당 게시물은 게시중단 처리\r\n되지 않습니\r\n다.\r\n6. 기타 \r\n- 자유홍보게시판 등 일부 게시판은 게시판 이용 \r\n규칙에 따라 글 작성 1시간 이후부터 3일 동안은 \r\n작성한 글\r\n을 삭제할 수 없습니다.\r\n\r\n\r\n제14조(광고의 게재 및 발신)\r\n1. 회사가 회원에게 서비스를 제공할 수 있는 투자\r\n기반의 일부는 광고게재를 통한 수익에서\r\n나옵니다. 회사는 회원이 등록한 게시물이나 그 \r\n내용을 활용한 광고게재 및 기타 서비스 를\r\n이용하면서 노출되는 광고를 게재할 수 있습니다. \r\n2. 회사는 회원이 광고성 정보 수신에 동의할 경\r\n우, 이메일, 푸시 알림, 1:1 대화, 문자 메시지 등 \r\n전자적 매체\r\n를 이용하여 광고성 정보를 발신할 수 있습니다.\r\n\r\n제15조(이용계약 해지)\r\n1. 회원은 언제든지 “탈퇴”를 통해 이용계약 해지 \r\n신청을 할 수 있으며, 회사는 관련법 등이\r\n정하는 바에 따라 이를 즉시 처리하여야 합니다. \r\n2. 회원이 이용계약을 해지할 경우, 관련법 및 통\r\n합개인정보 보호약관에 따라 모든 개인정보가 처\r\n리됩니다. \r\n- 회원이 자발적으로 탈퇴를 한 경우 1달 이내 재\r\n가입이 불가능합니다. \r\n- 약관 위반으로 회사에 의해 서비스 이용 제한이 \r\n되는 경우 6 달 이내 재가입이 불가능합니다.  \r\n3. 회원이 이용계약을 해지하더라도, 서비스 이용 \r\n시 작성하 거나 만들어진 모든 게시물은 삭제되지 \r\n않습니\r\n다. \r\n4. 회원이 이용계약을 해지한 뒤 새로 가입한 경\r\n우, 해지한 계정의 게시물 권한 등 모든 권리는 이\r\n양되지 않습\r\n니다.\r\n\r\n제16조(이용 제한 등)\r\n1. 회사는 회원이 이 약관의 의무를 위반하거나 서\r\n비스의 정상적인 운영을 방해한 경우, 주\r\n의, 경고, 일시정지, 영구이용정지, 계약해지 등의 \r\n조치를 즉시 취할 수 있으며, 회원은 법적책임을 \r\n부담합니\r\n다.\r\n2. 회사는 “주민등록법”을 위반한 명의도용 및 결\r\n제도용, 본인이 아닌 프로필사진 기재 및 도용, 전\r\n화번호 도\r\n용, “저작권법”을 위반한 불법프로그램의 제공 및 \r\n운영방해, 정보통신망, "정보통신망 이용촉진 및 \r\n정보보호 \r\n등에 관한 법률"을 위반한 불법통신 및 해킹, 프로\r\n그램의 배포, 접속권한 초과행위, “여신전문 금융\r\n업법”을 \r\n위반한 “이용자”의 신용카드 부정거래 등 이와 유\r\n사한 형태의 부정행위 등과 같이 관련법을 위반한 \r\n경우에는 \r\n주의, 경고, 일시정지, 영구 이용정지, 계약해지 등\r\n의 조치를 즉시 취할 수 있으며, 회원은 법적책임\r\n을 부담할 \r\n수 있습니다. \r\n3. 회사는 회원이 계속해서 1년 이상 로그인하지 \r\n않는 경우, 회원정보의 보호 및 운영의 효율성을 \r\n위해 이용\r\n을 제한할 수 있습니다. \r\n4. 본 조의 이용제한 범위 내에서 제한의 조건 및 \r\n세부내용은 회사의 이용제한정책에서 정하는 바\r\n에 의합니\r\n다. \r\n5. 본 조에 따라 서비스 이용을 제한하거나 계약을 \r\n해지하는 경우에는 회사는 제7조에 따라 통지합\r\n니다. \r\n6. 회원은 본 조에 따른 이용제한 등에 대해 회사\r\n가 정한 절차 에 따라 이의신청을 할 수 있습니다. \r\n이 때 이의\r\n가 정당하다고 회사가 인정하는 경우 회사는 즉시 \r\n서비스의 이용을 재개합니다.\r\n7. 본 조에 따라 이용제한이 되는 경우 서비스 이\r\n용을 통해 획 득한 혜택 등도 모두 이용중\r\n단, 또는 소멸되며, 회사는 이에 대해 별도로 보상\r\n하지 않습니다.\r\n\r\n제17조(책임제한)\r\n1. 회사는 다음의 경우, 어떠한 경우라도 책임을 \r\n지거나 보상 을 하지 않으며, 회원에게 귀책사유\r\n가 있을 경\r\n우, 별도의 통보 없이 자격을 제한, 정지 및 박탈할 \r\n수 있습니다. \r\n- 천재지변 또는 이에 준하는 불가항력으로 인하\r\n여 서비스를 제공할 수 없는 경우 \r\n- 회사가 무료로 제공하는 서비스가 변경, 중단되\r\n거나 장애가 생길 경우 \r\n- 회사가 고의·과실이 없음을 입증할 경우\r\n- 회원의 작성한 게시물에 대한 정보, 자료, 신뢰\r\n도, 정확성 등 에 대해 \r\n- 오프라인 모임에서의 회원 간이나 회원과 광고\r\n주 등 제3자 상호 간에 합의한 거래 등에 대해 \r\n- 회원이 서비스를 이용함에 있어 회사의 각 약관\r\n을 준수하지 않거나 의무를 다하지 않을 경우 \r\n2. 회사는 제1항 외 귀책사유로 인하여 재화 및 용\r\n역을 구매 한 회원에게 법률적으로 인과관계를 밝\r\n힐 수 있\r\n는 손해가 발 생하는 경우에는 그 손해를 배상할 \r\n책임이 있습니다.\r\n\r\n제18조(분쟁해결)\r\n1. 회사는 회원이 제기하는 문의, 정당한 의견 및 \r\n불만을 반영 및 처리하고 그 피해를 보상\r\n처리하기 위하여 상담창구를 운영합니다. \r\n2. 회사와 회원 간에 발생한 전자상거래 분쟁과 관\r\n련하여 회원의 피해구제신청이 있는 경우에는 공\r\n정거래위\r\n원회 또는 시 도지사가 의뢰하는 분쟁조정기관의 \r\n조정에 따를 수 있습니다.\r\n\r\n제19조(재판관할)\r\n1. 회사와 회원 간 제기된 소송은 대한민국법을 준\r\n거법으로 하며, 관할 법원에 제소합니다. 2. 회사\r\n와 회원 간 \r\n발생한 분쟁에 관한 소송은 제소 당시 회원의 주\r\n소에 의하고, 주소가 없는 경우 거소를 관할하는 \r\n지방법 원의 \r\n전속관할로 합니다. 단, 제소 당시 회원의 주소 또\r\n는 거소가 명확하지 아니한 경우의 관할법원은 민\r\n사소송법\r\n에 따라 정합니다. \r\n3. 해외에 주소나 거소가 있는 회원의 경우, 회사\r\n와 회원간 발생한 분쟁에 관한 소송은 전항에도 \r\n불구하고 대\r\n한민국 서울중 앙지방법원을 관할 법원으로 합니\r\n다.\r\n\r\n제20조(위치기반서비스)\r\n오드는 사용자가 쉽고 편하게 타 사용자와의 교류 \r\n기회를 가 질 수 있도록 돕기 위해 오드 서비스에 \r\n위치기반\r\n서비스를 포함시킬 수 있습니다. 오드의 위치기반\r\n서비스는 사용자의 단 말기기의 위치정보를 수집\r\n하는 위치\r\n정보사업자로부터 위치 정보를 전달받아 제공하\r\n는 무료서비스이며, 구체적으로는 사용자의 현재 \r\n위치를 기\r\n준으로 특정 블록(천안, 아산 등 시단위)에 가입자\r\n격을 부여하고 다른 이용자와 해당 블록과 관련된 \r\n모임 또는 \r\n게시물을 작성할 수있도록 하는 서비스 (소셜네트\r\n워킹서비스), 사용자의 현재 위치를 이용한 생활 \r\n정 보나 광\r\n고성 정보를 제공하는 서비스(정보제공서비스)가 \r\n있 습니다. \r\n오드는 위치정보의 보호 및 이용 등에 관한 법률\r\n의 규정에 따라 개인위치정보 및 위치 정보 이용·\r\n제공사실 확\r\n인자료를 6개월 이상 보관하며, 사용자가 동의의 \r\n전부 또는 일부를 철회한 때에는 오드는 철회한 \r\n부분에 해당\r\n하는 개인위치정보 및 위치정보 이용·제공사실 확\r\n인 자료를 지체 없이 파기하겠습니다. 만약, 오드\r\n가 사용자\r\n의 개인위치정보를 사용자가 지\r\n정하는 제3자에게 직접 제공하는 때에는 법령에 \r\n따라 개인위치정보를 수집한 스마 트폰 등으로 사\r\n용자에게 \r\n개인위치정보를 제공받는 자, 제공 일시 및 제공 \r\n목적을 즉시 통보하겠습니다. 의무자는 개인위치\r\n정보주체의 \r\n권리를 모두 행사할 수 있습니다. 오드는 사용자\r\n의 위치정보를 안전하게 보호하기 위하여 위치 정\r\n보관리책임\r\n자(박장훈 대표, 934wkdgns@naver.com)를 지\r\n정하고 있습니다. 만약 사용자와 오드 간의 위치\r\n정보와 관\r\n련\r\n한 분쟁에 대하여 협의가 어려운 때에는 사용자은 \r\n위치정보의 보호 및 이용 등 에 관한 법률 제 28조 \r\n2항 및 \r\n개인정보보호법 제43조의 규정 에 따라 개인정보 \r\n분쟁조정위원회에 조정을 신청할 수 있습니다.\r\n\r\n제21조(부칙)\r\n- 본 약관은 2021년 12월 7일부터 적용됩니다. \r\n- 본 약관은 타 약관보다 우선하며, 본 약관 제2조\r\n의 정의는 모든 약관에 적용됩니다. \r\n- 회사가 직접 제공하는 사이트 이외에 링크된 사\r\n이트에서는 모든 약관이 적용되지 않습니다. \r\n- 본 약관에 명시되어 있지 않은 사항은 관련 법령\r\n을 따릅니다.', '2021-10-22 10:40:33', NULL),
	(2, 'admin', '개인정보처리방침', '오드 개인정보보호약관\r\n\r\n오드는 이벤트, 토픽, 포스트, 유료 파트너십(수정) 등 회사가\r\n제공하는 다양한 서비스를 제공함에 있어, 정보를 어떻게 수집, 이용, 보관, \r\n파기하는 지에 대한 정보를 담은 방침을 의미합니다. 오드 통합개인정보보호약관은\r\n개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등\r\n국내의 개인정보 보호 법령을 준수하고 있으며, 각 서비스에서\r\n언제든지 이 방침을 확인할 수 있습니다.\r\n\r\n1. 수집하는 개인정보의 항목\r\n회원은 본인의 선택으로 회원가입을 한 뒤 서비스를 이용할 수 있습니다.\r\n이 경우, 회사는 회원가입 시점부터 아래와 같은 개인정보 중 일부를 수집합니다.\r\n단, 회원이 각 항목에 해당되지 않을 경우, 해당 항목의 개인정보는 \r\n절대 수집하지 않습니다.\r\n\r\n1) 회원 가입 시\r\n- 이메일, 비밀번호, 주소, 성별, 학교, 학과, 이름, 전화번호, 생년월일, 관심분야\r\n\r\n2) 대학교 메일 인증 시\r\n- 각 대학교 포털사이트 이메일 주소 등의 정보\r\n\r\n3) 고객 분쟁처리 및 상담 진행 시\r\n- 상담내역, 서비스 이용기록, 결제 및 환불 기록\r\n\r\n4) 제휴/협력 및 게시 요청 시\r\n- 단체명, 이름, 직책, 이메일, 연락처, 게시 요청 내용\r\n\r\n5) 서비스 이용과정에서 자동 수집되는 정보\r\n- IP Address, 쿠키, 방문일시, 서비스 이용기록, 불량 이용기록, 기기정보,\r\nADID, IDFA\r\n* 각 항목 또는 추가적으로 수집이 필요한 항목의 개인정보는\r\n문의하기를 통한 회원 지원 과정 및 별도의 알림창을 통해서 서비스 이용 중 수집될 수 있습니다.\r\n* 회사는 대학생 재학 중(휴학생 포함) 이외의 회원가입을 허가하지 않으며, \r\n개인정보를 수집하지 않습니다.\r\n* 회사는 인종, 사상, 의료정보 등 회원의 민감정보를 절대로 수집하지 않습니다.\r\n\r\n\r\n2. 개인정보의 수집 및 이용목적\r\n회사는 쾌적한 서비스 제공을 위해서 아래의 목적에 한해 개인정보를 이용합니다.\r\n\r\n1) 회원 식별, 가입의사 및 탈퇴의사 확인, 부정이용 및 중복가입방지, 이메일 중복확인\r\n등 회원관리\r\n2) 모임, 행사 등 서비스에서 지역 맞춤 서비스 개발 제공 개선\r\n3) 주소, 관심사 등 인구통계학적 자료 분석을 통한 맞춤형 서비스 및\r\n광고 제공\r\n4) 회원 문의/ 제안/ 제휴/ 협력/ 게시 요청 처리, 공지사항 전달\r\n5) 구매, 판매, 배송,공급, 지급, 제작,중개,중계, 당첨 등 회사와 회원 간\r\n체결된 약정 이행\r\n\r\n\r\n3. 개인정보 수집방법\r\n회사는 어플리케이션, 제휴사로부터의 전달, 거래과정 등을 통해\r\n개인정보를 수집합니다.\r\n\r\n\r\n4. 개인정보의 보유 및 이용기간\r\n이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이\r\n달성되면 지체없이 파기합니다. 단, 다음의 정보에 대해서는 아래의\r\n이유로 명시한 기간 동안 보존합니다.\r\n\r\n1) 회사 내부 방침에 의한 정보보유 사유\r\n보존항목 : 부정 이용기록\r\n- 보존 이유 : 부정이용방지\r\n- 보존 기간 : 5년\r\n보존항목 : 탈퇴 회원 개인정보\r\n-보존 이유 : 재가입 악용 방지, 명예훼손 등 권리침해 분쟁 및 수사협조\r\n- 보존 기간 : 1년\r\n* 커뮤니티 게시물 유출, 아이디 공유 등 서비스 부정사용 및 커뮤니티 이용규칙\r\n위반 회원의 재가입 및 이용 제한을 위해 휴대폰 번호, 이메일을 암호화하여\r\n최대 5년간 보관합니다.\r\n\r\n2) 관련 법령에 의한 정보보유 사유\r\n보존 항목 : 대금결제 및 재화 등의 공급에 관한 기록\r\n- 근거 법령 : 전자상거래 등에서의 소비자 보호에 관한 법률\r\n- 보존 기간: 5년\r\n보존 항목 : 계약 또는 청약철회 등에 관한 기록\r\n- 근거 법령 : 전자상거래 등에서의 소비자보호에 관한 법률\r\n- 보존 기간 : 5년\r\n보존 항목 : 소비자의 불만 또는 분쟁처리에 관한 기록\r\n- 근거 법령 : 전자상거래 등에서의 소비자보호에 관한 법률\r\n- 보존 기간: 3년\r\n보존 항목 : 대금결제 및 재화 등의 공급에 관한 기록\r\n- 근거 법령 : 전자상거래 등에서의 소비자보호에 관한 법률\r\n- 보존 기간 : 5년\r\n보존 항목 : 본인확인에 관한 기록\r\n- 근거 법령 : 정보통신망 이용촉진 및 정보보호 등에 관한 법률\r\n- 보존 기간 : 6개월\r\n보존 항목 : 방문에 관한 기록\r\n- 근거 법령 : 통신비밀보호법\r\n- 보존 기간 : 3개월\r\n\r\n\r\n5. 개인정보의 파기 절차 및 방법\r\n회사는 개인정보 수집 및 이용목적이 달성된 후에는 지체없이\r\n해당 정보를 파기합니다. 종이에 출력된 개인정보는 분쇄기로 분쇄하거나\r\n소각을 통하여 파기하고, 전자적 파일 형태로 저장된 개인정보는\r\n기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.\r\n(비식별화된 정보는 일방향 암호화된 정보이므로 , 복호화가 불가능하며,\r\n누구라도 이 정보로 개인을 식별하거나 유추할 수 없습니다.)\r\n\r\n\r\n6. 개인정보의 제공 및 위탁\r\n회사는 회원이 서비스 이용과정 등에서 따로 동의하는 경우나 법령에\r\n규정된 경우를 제외하고는 사용자 개인정보를 위에서 언급한 목적 범위를\r\n초과하여 제공하거나 공유하지 않습니다. 단, 이용자가 외부 제휴사의 서비스를 이용하기 위하여 개인정보 제\r\n공에 직접 동의를 한 경우, 그리고 관련 법령에 의거해 오드에 개인정보 제출 의무가 발생한 경우, 이용자의 \r\n생명이나 안전에 급박한 위험이 확인되어 이를 해소하기 위한 경우에 한하여 개인정보를 제공하고 있습니다.\r\n\r\n오드는 편리하고 더 나은 서비스를 제공하기 위해 업무 중 일부를 외부에 위탁하고 있습니다.\r\n\r\n오드는 서비스 제공을 위하여 필요한 업무 중 일부를 외부 업체에 위탁하고 있으며, 위탁받은 업체가 개인정\r\n보보호법에 따라 개인정보를 안전하게 처리하도록 필요한 사항을 규정하고 관리/감독을 하고 있습니다. 오드\r\n가 수탁업체에 위탁하는 업무와 관련된 서비스를 이용하지 않는 경우, 이용자의 개인정보가 수탁업체에 제공\r\n되지 않습니다.\r\n\r\n\r\n\r\n\r\n7. 이용자 및 법정 대리인의 권리, 의무 및 행사 방법\r\n사용자는 언제든지 사용자 개인정보를 조회하거나 수정할수 있으며\r\n수집 이용에 대한 동의 철회 또는 가입 해지를 요청할 수도 있습니다.\r\n보다 구체적으로는 서비스 내 설정 기능을 통한 변경, 가입해지(동의 철회)를\r\n위해서는 서비스 내 "계정탈퇴"를 클릭하면 되며, 운영자에게 이메일이나\r\n별도 게시판으로 문의할 경우 지체없이 조치하겠습니다.\r\n\r\n\r\n8. 개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항\r\n회사는 이용자의 정보를 자동으로 저장하고 찾아내는 \'쿠키\'등을 운용합니다.\r\n쿠키란 웹사이트 운영하는데 이용되는 서버가 귀하의 브라우저에 보내는\r\n아주 작은 텍스트 파일로서 귀하의 컴퓨터 하드디스크에 저장됩니다.\r\n\r\n1) 쿠키 등의 사용목적\r\n개인화되고 맞춤화된 서비스를 제공하기 위해서 이용자의 정보를 저장하고 수시로 \r\n불러오는 쿠키를 사용합니다. 이용자가 웹사이트에 방문할 경우 웹 사이트 서버는\r\n이용자의 디바이스에 저장되어 있는 쿠키의 내용을 읽어 이용자의 환경설정을\r\n유지하고 맞춤화된 서비스를 제공하게 됩니다. 쿠키는 이용자가\r\n웹사이트를 방문할 때, 웹 사이트 사용을 설정한대로 접속하고\r\n편리하게 사용할 수 있도록 돕습니다. 또한 이용자의 웹사이트 방문 기록,\r\n이용 형태를 통해서 최적화된 광고 등 맞춤형 정보를 제공하기 위해 \r\n활용됩니다.\r\n\r\n2) 쿠키 설정 거부방법\r\n쿠키 설정을 거부하는 방법으로는 회원님이 사용하시는 앱이나 웹 브라우저의 옵션을\r\n선택함으로써 모든 쿠키를 허용하거나 쿠키를 저장할 때마다 확인을 거치거나,\r\n모든 쿠키의 저장을 거부할 수 있습니다.\r\n\r\n\r\n9. 개인정보보호를 위한 기술적 관리적 조치\r\n회사는 이용자의 개인정보를 취급함에 있어 개인정보가 분실, 도난, 누출, 변조\r\n또는 훼손되지 않도록 안정성 확보를 위하여 다음과 같은 기술적, 관리적 대책을\r\n강구하고 있습니다.\r\n\r\n1) 이용자의 개인정보는 비밀번호에 의해 보호되며, 중요한 데이터는\r\n파일 및 전송데이터를 암호화하거나 파일 잠금 기능을 사용하는 등의 별도 보안기능을 통해\r\n보호하고 있습니다.\r\n2) 회사는 해킹이나 컴퓨터 바이러스 등에 의해 이용자의 개인정보가 유출되거나\r\n훼손되는 것을 막기 위해 외부로부터 접근이 통제된 구역에 시스템을 설치하고\r\n침입 차단장치 이용 및 침입 탐지시스템을 설치하여 24시간 감시하고 있습니다.\r\n3) 회사는 개인정보를 처리할 수 있도록 체계적으로 구성한 데이터베이스시스템에\r\n대한 접근권한의 부여, 변경, 말소 등에 관한 기준을 수립하고 비밀번호의 생성방법,\r\n변경 주기 등을 규정 운영하며 기타 개인정보에 대한 접근통제를 위해 필요한 조치를\r\n다하고 있습니다.\r\n4) 개인정보관련 취급 직원은 담당자에 한정시켜 최소화하고 새로운 보안기술의\r\n습득 및 개인정보 보호 의무에 관해 정기적인 교육을 실시하며 별도의 비밀번호를\r\n부여하여 접근 권한을 관리하는 등 관리적 대책을 시행하고 있습니다.\r\n5) 이용자가 사용하는 ID와 비밀번호는 원칙적으로 이용자만 사용하도록 되어 \r\n있습니다. 회사는 이용자의 개인적인 부주의로 ID, 비밀번호, 이메일 등 개인정보가\r\n유출되어 발생한 문제와 기본적인 인터넷의 위험성 때문에 일어나는 일들에 대해\r\n책음을 지지 않습니다.\r\n\r\n\r\n10. 개인정보관리책임자 및 문의처\r\n회사의 서비스를 이용하며 발생하는 모든 개인정보보호 관련 민원을 \r\n개인정보관리책임자 혹은 담당부서로 제보하실수 있습니다.\r\n\r\n개인정보관리책임자\r\n- 이름 : 박장훈\r\n- 직위 : 대표\r\n- 연락처 : 934wkdgns@naver.com\r\n\r\n\r\n11. 개인정보보호약관의 개정과 고지\r\n오드는 법률이나 서비스의 변경사항을 반영하기 위한 목적 등으로\r\n개인정보보호약관을 수정할 수 있습니다. 개인정보보호약관이 변경되는 경우\r\n오드는 변경사항을 게시하며, 변경된 개인정보보호약관은 게시한 날로부터\r\n7일 후부터 효력이 발생합니다.\r\n\r\n공고일자 : (2021.11.17일)\r\n시행일자 : (2021.11.17 ~ 2021.12.17)', '2021-10-22 10:40:59', NULL),
	(3, 'admin', '위치기반서비스', '[위치기반서비스 이용약관 ...]DESO 사람들이 서로 교감을 나누고 서로의 다양성을 인정하는 열린 세상을 만드는 데 일조하고자 합니다. 123123', '2021-10-22 10:41:23', NULL);
/*!40000 ALTER TABLE `information` ENABLE KEYS */;

-- 테이블 idenit.member 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `m_no` bigint NOT NULL AUTO_INCREMENT COMMENT '번호',
  `m_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '아이디',
  `m_pw` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '비밀번호',
  `m_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '이름',
  `m_age` int DEFAULT NULL COMMENT '나이',
  `m_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '핸드폰번호',
  `m_email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '이메일',
  `m_school` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '학교',
  `m_study` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '학과',
  `m_birth` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '생일',
  `m_img1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '이미지1',
  `m_img2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '이미지2',
  `m_img3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '이미지3',
  `m_img4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '이미지4',
  `m_zipcode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '우편번호',
  `m_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '주소',
  `m_address_sub` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '상세주소',
  `m_locationX` varchar(255) DEFAULT NULL COMMENT 'x좌표',
  `m_locationY` varchar(255) DEFAULT NULL COMMENT 'y좌표',
  `m_about_me` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '자기소개',
  `m_state` tinyint unsigned DEFAULT '0' COMMENT '회원상태 0: 일반, 1:블랙',
  `m_studentFl` tinyint unsigned DEFAULT '0' COMMENT '대학교인증여부 0: 미인증 1:인증',
  `m_joinFl` tinyint unsigned DEFAULT '0' COMMENT '회원가입상태 0: 미승인, 1:승인',
  `m_delFl` tinyint unsigned DEFAULT '0' COMMENT '회원탈퇴상태 0: 미탈퇴, 1:탈퇴',
  `m_allimFl` tinyint DEFAULT '1' COMMENT '회원알림설정 0: 거절 1:수락',
  `m_r_count` int DEFAULT '0' COMMENT '경고횟수',
  `del_reason` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '탈퇴사유',
  `regDt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modDt` timestamp NULL DEFAULT NULL,
  `delDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`m_no`),
  UNIQUE KEY `m_id` (`m_id`),
  UNIQUE KEY `m_phone` (`m_phone`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='회원';

-- 테이블 데이터 idenit.member:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` (`m_no`, `m_id`, `m_pw`, `m_name`, `m_age`, `m_phone`, `m_email`, `m_school`, `m_study`, `m_birth`, `m_img1`, `m_img2`, `m_img3`, `m_img4`, `m_zipcode`, `m_address`, `m_address_sub`, `m_locationX`, `m_locationY`, `m_about_me`, `m_state`, `m_studentFl`, `m_joinFl`, `m_delFl`, `m_allimFl`, `m_r_count`, `del_reason`, `regDt`, `modDt`, `delDt`) VALUES
	(69, 'qwe', 'qwe', '김혁', NULL, '01051891111', 'wgilooy97@naver.com', '서울대', '국어국문과', '19970301', 'img_kakao.jpg', NULL, NULL, NULL, NULL, '부천시 고강동', NULL, '37.529042293663096', '126.81506360082462', NULL, 0, 0, 1, 0, 1, 0, NULL, '2021-12-20 17:24:16', '2021-12-23 15:22:19', NULL);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;

-- 테이블 idenit.notice 구조 내보내기
CREATE TABLE IF NOT EXISTS `notice` (
  `n_no` bigint NOT NULL AUTO_INCREMENT COMMENT '번호',
  `n_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '작성자',
  `n_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '제목',
  `n_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '내용',
  `n_state` tinyint DEFAULT '0' COMMENT '중요글 설정  0: 일반 , 1: 중요',
  `n_hit` bigint DEFAULT '0' COMMENT '조회수',
  `regDt` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDt` timestamp NULL DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`n_no`),
  KEY `n_id` (`n_id`),
  CONSTRAINT `notice_ibfk_1` FOREIGN KEY (`n_id`) REFERENCES `admin` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='공지사항';

-- 테이블 데이터 idenit.notice:~7 rows (대략적) 내보내기
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` (`n_no`, `n_id`, `n_title`, `n_content`, `n_state`, `n_hit`, `regDt`, `modDt`) VALUES
	(1, 'admin', 'DESO 서비스 오픈합니다중요', 'hi', 1, 7, '2021-10-25 11:13:24', NULL),
	(2, 'admin', 'DESO 서비스 오픈합니다', '안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.', 0, 0, '2021-10-22 11:13:24', NULL),
	(3, 'admin', 'DESO 서비스 오픈합니다', '안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.', 0, 1, '2021-10-21 11:13:24', NULL),
	(4, 'admin', 'DESO 서비스 오픈합니다', '안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.', 0, 4, '2021-10-27 11:13:24', NULL),
	(5, 'admin', 'DESO 서비스 오픈합니다', '안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.', 0, 4, '2021-10-26 11:13:24', NULL),
	(6, 'admin', 'DESO 서비스 오픈합니다', '안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.안녕하세여 DESO입니다.', 0, 9, '2021-10-28 11:13:24', NULL),
	(17, 'admin', '1111', '1122333', 1, 6, '2021-11-19 06:58:24', NULL);
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;

-- 테이블 idenit.report 구조 내보내기
CREATE TABLE IF NOT EXISTS `report` (
  `r_no` bigint NOT NULL AUTO_INCREMENT COMMENT '번호',
  `r_kind` varchar(50) NOT NULL DEFAULT '회원' COMMENT '종류',
  `r_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '신고한 아이디',
  `rd_id_no` bigint DEFAULT NULL COMMENT '신고받은 회원 번호',
  `rd_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '신고받은 회원 아이디',
  `rd_board_no` bigint DEFAULT NULL COMMENT '신고받은 게시판번호',
  `rd_board_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '신고받은 게시판이름',
  `r_title` varchar(50) NOT NULL COMMENT '제목(유형)',
  `r_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '내용',
  `r_process` tinyint DEFAULT '0' COMMENT '처리여부 0:미처리 1: 처리',
  `regDt` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDt` timestamp NULL DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`r_no`),
  KEY `r_id` (`r_id`),
  KEY `FK_report_board` (`rd_board_no`),
  CONSTRAINT `FK_report_board` FOREIGN KEY (`rd_board_no`) REFERENCES `board` (`b_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_report_member_3` FOREIGN KEY (`r_id`) REFERENCES `member` (`m_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='신고내역';

-- 테이블 데이터 idenit.report:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
INSERT INTO `report` (`r_no`, `r_kind`, `r_id`, `rd_id_no`, `rd_id`, `rd_board_no`, `rd_board_title`, `r_title`, `r_content`, `r_process`, `regDt`, `modDt`) VALUES
	(21, '행사', 'qwe', NULL, NULL, 54, '천안고 축제', '비매너행위', 'qweqwe', 0, '2021-12-21 10:40:53', NULL);
/*!40000 ALTER TABLE `report` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
