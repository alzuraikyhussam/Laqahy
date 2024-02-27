SET NOCOUNT ON;
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;

-- Database: laqahy
-- DROP DATABASE laqahy;
-- CREATE DATABASE laqahy;
USE laqahy;

-- Change database encoding
ALTER DATABASE laqahy
COLLATE Arabic_CI_AS;

-- Create cities table
CREATE TABLE cities (
    city_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    city_name NVARCHAR(150) NOT NULL
);

-- Create directorates table
CREATE TABLE directorates (
    directorate_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    directorate_name NVARCHAR(150) NOT NULL,
    directorate_city_name INT NOT NULL,
    CONSTRAINT FK_directorates_cities FOREIGN KEY (directorate_city_name) REFERENCES cities(city_id)
);

-- Create dosage_type table
CREATE TABLE dosage_type (
    dt_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    dt_type NVARCHAR(150) NOT NULL
);

-- Create dosage_levels table
CREATE TABLE dosage_levels (
    dl_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    dl_level NVARCHAR(150) NOT NULL,
    dl_dosage_type INT NULL,
    CONSTRAINT FK_dosage_levels_dosage_type FOREIGN KEY (dl_dosage_type) REFERENCES dosage_type(dt_id)
);

-- Create gender table
CREATE TABLE gender (
    gender_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    gender_type NVARCHAR(150) NOT NULL
);

-- Create health_centers table
CREATE TABLE health_centers (
    hc_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    hc_name NVARCHAR(150) NOT NULL,
    hc_phone NVARCHAR(150) NOT NULL,
    hc_address NVARCHAR(150) NOT NULL,
    hc_city INT NULL,
    hc_directorate INT NULL,
    hc_logo NVARCHAR(150) NULL,
    hc_details NVARCHAR(300) NULL,
    CONSTRAINT FK_health_centers_cities FOREIGN KEY (hc_city) REFERENCES cities(city_id),
    CONSTRAINT FK_health_centers_directorates FOREIGN KEY (hc_directorate) REFERENCES directorates(directorate_id)
);

-- Create branches table
CREATE TABLE branches (
    branch_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    branch_name NVARCHAR(150) NOT NULL,
    branch_hc_name INT NULL,
    CONSTRAINT FK_branches_health_centers FOREIGN KEY (branch_hc_name) REFERENCES health_centers(hc_id)
);

-- Create permission_type table
CREATE TABLE permission_type (
    pt_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    pt_type NVARCHAR(150) NOT NULL
);

-- Create employees table
CREATE TABLE employees (
    emp_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    emp_name NVARCHAR(150) NOT NULL,
    emp_phone NVARCHAR(150) NOT NULL,
    emp_address NVARCHAR(150) NOT NULL,
    emp_health_center INT NULL,
    emp_branch_name INT NULL,
    emp_birthdate DATE NOT NULL,
    emp_gender INT NULL,
    emp_username NVARCHAR(150) NOT NULL,
    emp_password NVARCHAR(150) NOT NULL,
    emp_permission_type INT NOT NULL,
    CONSTRAINT FK_employees_gender FOREIGN KEY (emp_gender) REFERENCES gender(gender_id),
    CONSTRAINT FK_employees_health_centers FOREIGN KEY (emp_health_center) REFERENCES health_centers(hc_id),
    CONSTRAINT FK_employees_permission_type FOREIGN KEY (emp_permission_type) REFERENCES permission_type(pt_id),
    CONSTRAINT FK_employees_branches FOREIGN KEY (emp_branch_name) REFERENCES branches(branch_id)
);

-- Create mother_data table
CREATE TABLE mother_data (
    mother_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    mother_name NVARCHAR(150) NOT NULL,
    mother_address NVARCHAR(150) NOT NULL,
    mother_phone NVARCHAR(150) NOT NULL,
    mother_directorate INT NULL,
    CONSTRAINT FK_mother_data_directorates FOREIGN KEY (mother_directorate) REFERENCES directorates(directorate_id)
);

-- Create vaccine_type table
CREATE TABLE vaccine_type (
    vactype_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    vactype_type NVARCHAR(150) NOT NULL
);

-- Create visit_type table
CREATE TABLE visit_type (
    vt_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    vt_type NVARCHAR(150) NOT NULL
);

-- Create child_data table
CREATE TABLE child_data (
    child_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    child_name NVARCHAR(150) NOT NULL,
    child_mother_name INT NULL,
    child_birthdate DATE NOT NULL,
    child_place_birth NVARCHAR(150) NOT NULL,
    child_gender INT NULL,
    CONSTRAINT FK_child_data_gender FOREIGN KEY (child_gender) REFERENCES gender(gender_id),
    CONSTRAINT FK_child_data_mother_data FOREIGN KEY (child_mother_name) REFERENCES mother_data(mother_id)
);

-- Create vaccine_data table
CREATE TABLE vaccine_data (
    vd_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    vd_vaccine_name NVARCHAR(150) NOT NULL,
    vd_manufacturer NVARCHAR(150) NOT NULL,
    vd_vaccine_number INT NOT NULL,
    vd_dosage INT NOT NULL,
    vd_vaccine_available INT NOT NULL
);

-- Create child_statement table
CREATE TABLE child_statement (
    cs_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    cs_child_name INT NULL,
    cs_health_center INT NULL,
    cs_branch_name INT NULL,
    cs_emp_name INT NULL,
    cs_vaccine_type INT NULL,
    cs_visit_type INT NULL,
    cs_dosage_type INT NULL,
    cs_dosage_date DATE NOT NULL,
    cs_return_date DATE NOT NULL,
    CONSTRAINT FK_child_statement_child_data FOREIGN KEY (cs_child_name) REFERENCES child_data(child_id),
    CONSTRAINT FK_child_statement_health_centers FOREIGN KEY (cs_health_center) REFERENCES health_centers(hc_id),
    CONSTRAINT FK_child_statement_branches FOREIGN KEY (cs_branch_name) REFERENCES branches(branch_id),
    CONSTRAINT FK_child_statement_employees FOREIGN KEY (cs_emp_name) REFERENCES employees(emp_id),
    CONSTRAINT FK_child_statement_vaccine_type FOREIGN KEY (cs_vaccine_type) REFERENCES vaccine_type(vactype_id),
    CONSTRAINT FK_child_statement_visit_type FOREIGN KEY (cs_visit_type) REFERENCES visit_type(vt_id),
    CONSTRAINT FK_child_statement_dosage_type FOREIGN KEY (cs_dosage_type) REFERENCES dosage_type(dt_id)
);

-- Create vaccine_statement table
CREATE TABLE vaccine_statement (
    vs_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    vs_vaccine_name INT NULL,
    vs_health_center INT NULL,
    vs_branch_name INT NULL,
    vs_emp_name INT NULL,
    vs_child_name INT NULL,
    vs_visit_type INT NULL,
    vs_dosage_type INT NULL,
    vs_dosage_date DATE NOT NULL,
    CONSTRAINT FK_vaccine_statement_vaccine_data FOREIGN KEY (vs_vaccine_name) REFERENCES vaccine_data(vd_id),
    CONSTRAINT FK_vaccine_statement_health_centers FOREIGN KEY (vs_health_center) REFERENCES health_centers(hc_id),
    CONSTRAINT FK_vaccine_statement_branches FOREIGN KEY (vs_branch_name) REFERENCES branches(branch_id),
    CONSTRAINT FK_vaccine_statement_employees FOREIGN KEY (vs_emp_name) REFERENCES employees(emp_id),
    CONSTRAINT FK_vaccine_statement_child_data FOREIGN KEY (vs_child_name) REFERENCES child_data(child_id),
    CONSTRAINT FK_vaccine_statement_visit_type FOREIGN KEY (vs_visit_type) REFERENCES visit_type(vt_id),
    CONSTRAINT FK_vaccine_statement_dosage_type FOREIGN KEY (vs_dosage_type) REFERENCES dosage_type(dt_id)
);

-- Create users table
CREATE TABLE users (
    user_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    user_username NVARCHAR(150) NOT NULL,
    user_password NVARCHAR(150) NOT NULL,
    user_type INT NOT NULL,
    CONSTRAINT FK_users_permission_type FOREIGN KEY (user_type) REFERENCES permission_type(pt_id)
);

-- Populate cities table
INSERT INTO cities (city_name) VALUES
('تعز'),
('صنعاء'),
('عدن');

-- Populate directorates table
INSERT INTO directorates (directorate_name, directorate_city_name) VALUES
('المظفر', 1),
('القاهرة', 1),
('صالة', 1);

-- Populate dosage_type table (if needed)

-- Populate gender table
INSERT INTO gender (gender_type) VALUES
('ذكر'),
('انثى');

-- Populate health_centers table
INSERT INTO health_centers (hc_name, hc_phone, hc_address, hc_city, hc_directorate) VALUES
('مستوصف التعاون', '777777777-733333333', 'المسبح - جوار حديقة التعاون', 1, 2),
('مستوصف المظفر', '777777777-733333333', 'حي الميدان - جوار مجمع هائل للبنات', 1, 1),
('مركز التضامن', '777777777-733333333', 'بيرباشا - جوار نادي الصقر', 1, 1);

-- Populate permission_type table
INSERT INTO permission_type (pt_type) VALUES
('Admin'),
('User');

-- Populate vaccine_type table (if needed)

-- Populate visit_type table
INSERT INTO visit_type (vt_type) VALUES
('زيارة أولى'),
('زيارة تابعة'),
('زيارة تحصين');

-- Populate child_data table (if needed)

-- Populate vaccine_data table
INSERT INTO vaccine_data (vd_vaccine_name, vd_manufacturer, vd_vaccine_number, vd_dosage, vd_vaccine_available) VALUES
('Polio', 'منظمة الصحة العالمية', 1, 1, 100),
('BCG', 'منظمة الصحة العالمية', 1, 1, 100),
('Hepatitis', 'منظمة الصحة العالمية', 1, 1, 100),
('Diptheria', 'منظمة الصحة العالمية', 1, 1, 100),
('Tetanus', 'منظمة الصحة العالمية', 1, 1, 100),
('Pertussis', 'منظمة الصحة العالمية', 1, 1, 100),
('Influenza', 'منظمة الصحة العالمية', 1, 1, 100),
('Measles', 'منظمة الصحة العالمية', 1, 1, 100),
('Mumps', 'منظمة الصحة العالمية', 1, 1, 100),
('Rubella', 'منظمة الصحة العالمية', 1, 1, 100),
('Varicella', 'منظمة الصحة العالمية', 1, 1, 100),
('Typhoid', 'منظمة الصحة العالمية', 1, 1, 100),
('Rotavirus', 'منظمة الصحة العالمية', 1, 1, 100);
