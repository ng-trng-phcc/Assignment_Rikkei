create database ss08_bai_th;

create table khach_hang
(
    id         serial primary key,
    ma_kh      varchar(20) unique not null,
    ho_ten     varchar(100)       not null,
    so_du      decimal(15, 2) default 0.00,
    trang_thai varchar(20)    default 'ACTIVE',
    created_at timestamp      default now()
);

create table tai_khoan
(
    id            serial primary key,
    ma_tk         varchar(20) unique not null,
    khach_hang_id int references khach_hang (id),
    so_du         decimal(15, 2) default 0.00,
    loai_tk       varchar(50)    default 'THUONG',
    trang_thai    varchar(20)    default 'ACTIVE',
    created_at    timestamp      default now()
);

create table giao_dich
(
    id                serial primary key,
    ma_gd             varchar(30) unique not null,
    tai_khoan_id      int references tai_khoan (id),
    loai_gd           varchar(20)        not null check ( loai_gd in ('CHUYEN_TIEN', 'RUT_TIEN', 'GUI_TIEN') ),
    so_tien           decimal(15, 2)     not null,
    tai_khoan_doi_tac int,
    noi_dung          text,
    trang_thai        varchar(20) default 'PENDING',
    created_at        timestamp   default now()
);

create table lich_su_so_du
(
    id           serial primary key,
    tai_khoan_id int references tai_khoan (id),
    so_du_truoc  decimal(15, 2),
    so_du_sau    decimal(15, 2),
    thoi_gian    timestamp default now()
);


-- A. Procedure chuyển tiền
create or replace procedure chuyen_tien(
    p_ma_tk_nguoi_gui varchar,
    p_ma_tk_nguoi_nhan varchar,
    p_so_tien decimal,
    noi_dung text
)
    language plpgsql as
$$
declare
    v_so_du_ben_gui  decimal(15, 2);
    v_so_du_ben_nhan decimal(15, 2);

begin
    -- 1. Kiem tra xem tai khoan co active hay khong
    if not exists(select 1 from tai_khoan where ma_tk = p_ma_tk_nguoi_gui and trang_thai = 'ACTIVE') then
        raise exception 'Tai khoan nguoi gui khong hop le';
    elseif not exists(select 1 from tai_khoan where ma_tk = p_ma_tk_nguoi_nhan and trang_thai = 'ACTIVE') then
        raise exception 'Tai khoan nguoi nhan khong hop le';
    end if;

    -- 2. Kiểm tra số dư nguoi gui co đủ khong
    select so_du
    into v_so_du_ben_gui
    from tai_khoan
    where ma_tk = p_ma_tk_nguoi_gui;

    if v_so_du_ben_gui < p_so_tien then
        raise exception 'So du trong tai khoan khong du de thuc hien giao dich nay';
    end if;

    -- 3. Ghi nhận giao dịch
    -- Ben nguoi gui
    insert into lich_su_so_du (tai_khoan_id, so_du_truoc, so_du_sau)
    values (p_ma_tk_nguoi_gui, v_so_du_ben_gui, v_so_du_ben_gui - p_so_tien);

    -- Ben nguoi nhan
    select so_du
    into v_so_du_ben_nhan
    from tai_khoan tk
    where tk.ma_tk = p_ma_tk_nguoi_nhan;

    insert into lich_su_so_du (tai_khoan_id, so_du_truoc, so_du_sau)
    values (p_ma_tk_nguoi_nhan, v_so_du_ben_nhan, v_so_du_ben_nhan + p_so_tien);

    -- 4. Cập nhật số dư 2 tài khoản
    -- Ben nguoi gui
    update tai_khoan
    set so_du = so_du - p_so_tien
    where ma_tk = p_ma_tk_nguoi_gui;

    -- Ben nguoi nhan
    update tai_khoan
    set so_du = so_du + p_so_tien
    where ma_tk = p_ma_tk_nguoi_nhan;

    raise notice 'Giao dich thanh cong';

exception
    when others then
        rollback;
        raise;
end;
$$;


-- B. Procedure rút tiền
create or replace procedure rut_tien(
    p_ma_tk varchar(20),
    p_so_tien decimal(15, 2)
)
    language plpgsql as
$$
declare
    v_so_du decimal(15, 2);
begin
    -- 1. Kiem tra tai khoan co ton tai khong
    if not exists(select 1 from tai_khoan where ma_tk = p_ma_tk and trang_thai = 'ACTIVE') then
        raise exception 'Tai khoan khong hop le';
    end if;

    -- 2. Kiem tra so du co du khong
    select so_du
    into v_so_du
    from tai_khoan tk
    where tk.ma_tk = p_ma_tk;

    if v_so_du < p_so_tien then
        raise exception 'So du tai khoan khong du de thuc hien rut tien';
    end if;

    -- 3. Tru tien tai khoan
    update tai_khoan
    set so_du = so_du - p_so_tien
    where ma_tk = p_ma_tk;

    -- 4. Ghi log
    insert into lich_su_so_du (tai_khoan_id, so_du_truoc, so_du_sau)
    values (p_ma_tk, v_so_du, v_so_du - p_so_tien);

    raise notice 'Rut tien thanh cong';

exception
    when others then
        rollback;
        raise;
end;
$$;

-- C. Procedure với OUT parameters: thong_tin_tai_khoan
create or replace procedure thong_tin_tai_khoan(
    p_ma_tk varchar(20),
    out p_ho_ten varchar(100),
    out p_so_du decimal(15, 2),
    out p_so_giao_dich int
)
    language plpgsql as
$$
begin
    select ho_ten
    into p_ho_ten
    from tai_khoan
             join khach_hang kh on kh.id = tai_khoan.khach_hang_id
    where ma_tk = p_ma_tk;

    select tai_khoan.so_du
    into p_so_du
    from tai_khoan
             join khach_hang kh on kh.id = tai_khoan.khach_hang_id
    where ma_tk = p_ma_tk;

    select count(ma_gd)
    into p_so_giao_dich
    from tai_khoan tk
             join giao_dich gd on tk.id = gd.tai_khoan_id
    where tk.ma_tk = p_ma_tk;
end;
$$;

do
$$
    declare
        v_ho_ten       varchar;
        v_so_du        varchar;
        v_so_giao_dich int;
    begin
        call thong_tin_tai_khoan(1, v_ho_ten, v_so_du, v_so_giao_dich);
        raise notice 'Thong tin tai khoan: |Ho va ten: %|So du: %|So giao dich: %|', v_ho_ten, v_so_du, v_so_giao_dich;
    end;
$$;

/*
    D. Procedure phân loại khách hàng
    Logic:

        Nếu số dư > 1 tỷ → 'VIP'
        Nếu số dư > 100 triệu → 'GOLD'
        Nếu số dư > 10 triệu → 'SILVER'
        Còn lại → 'STANDARD'
*/
create or replace procedure phan_loai_khach_hang(
    p_ma_tk varchar(20)
)
    language plpgsql as
$$
    declare
        v_so_du   decimal(15, 2);
        v_loai_tk varchar(50);
    begin
        -- 1. Kiem tra tai khoan co ton tai khong
        if not exists(select 1 from tai_khoan where ma_tk = p_ma_tk) then
            raise exception 'Tai khoan khong hop le';
        end if;

        -- 2. Lay so du
        select so_du
        into v_so_du
        from tai_khoan tk
        where tk.ma_tk = p_ma_tk;

        -- 3. Phan loai tk
        if v_so_du > 1000000000 then
            v_loai_tk := 'VIP';
        elseif v_so_du > 100000000 then
            v_loai_tk := 'GOLD';
        elseif v_so_du > 10000000 then
            v_loai_tk := 'SILVER';
        else
            v_loai_tk := 'STANDARD';
        end if;

        -- 4. Cap nhat loai tk
        update tai_khoan
        set loai_tk = v_loai_tk
        where ma_tk = p_ma_tk;
    exception
        when others then
            rollback;
            raise;
    end;
$$;

