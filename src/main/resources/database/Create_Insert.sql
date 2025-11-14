USE PolyOE;

CREATE TABLE Users
(
    Id       VARCHAR(20) PRIMARY KEY,
    Password VARCHAR(50) NOT NULL,
    Fullname VARCHAR(50),
    Email    VARCHAR(50),
    Admin    BIT
);

CREATE TABLE Video
(
    Id          VARCHAR(20) PRIMARY KEY,
    Title       VARCHAR(100) NOT NULL,
    Poster      VARCHAR(255),
    Views       INT DEFAULT 0,
    Description VARCHAR(255),
    Active      BIT
);

CREATE TABLE Favorite
(
    Id       INT PRIMARY KEY,
    UserId   VARCHAR(20) NOT NULL,
    VideoId  VARCHAR(20) NOT NULL,
    LikeDate DATE        NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users (Id),
    FOREIGN KEY (VideoId) REFERENCES Video (Id)
);

CREATE TABLE Share
(
    Id        INT PRIMARY KEY AUTO_INCREMENT,
    UserId    VARCHAR(20)  NOT NULL,
    VideoId   VARCHAR(20)  NOT NULL,
    Emails    VARCHAR(100) NOT NULL,
    ShareDate DATE         NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users (Id),
    FOREIGN KEY (VideoId) REFERENCES Video (Id)
);

INSERT INTO Users (Id, Password, Fullname, Email, Admin)
VALUES ('user01', 'password01', 'Nguyễn Văn A', 'nguyenvana@example.com', 0),
       ('admin01', 'adminpass', 'Trần Thị B', 'tranthib@example.com', 1),
       ('user02', 'userpass02', 'Lê Văn C', 'levanc@example.com', 0);

INSERT INTO Video (Id, Title, Poster, Views, Description, Active)
VALUES ('vdo01', 'Hướng dẫn SQL cơ bản', 'images/sql_basic.jpg', 1500, 'Bài hướng dẫn chi tiết về các lệnh SQL cơ bản.',
        1),
       ('vdo02', 'Kỹ thuật lập trình web', 'images/web_dev.png', 850,
        'Giới thiệu về các công nghệ và kỹ thuật lập trình web hiện đại.', 1),
       ('vdo03', 'Khám phá vũ trụ', 'images/space_doc.gif', 3200, 'Phim tài liệu hấp dẫn về các thiên hà và hành tinh.',
        0);

INSERT INTO Favorite (Id, UserId, VideoId, LikeDate)
VALUES (1, 'user01', 'vdo01', '2025-10-20'),
       (2, 'user02', 'vdo01', '2025-11-01'),
       (3, 'user01', 'vdo02', '2025-11-10');

INSERT INTO Share (UserId, VideoId, Emails, ShareDate)
VALUES ('user01', 'vdo02', 'friend1@mail.com,friend2@mail.com', '2025-11-11'),
       ('admin01', 'vdo01', 'colleague@work.com', '2025-11-12');