-- Table: COMPANY
CREATE TABLE COMPANY (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE INDEX idx_company_name ON COMPANY(name);

-- Table: EMPLOYEE
CREATE TABLE EMPLOYEE (
    id SERIAL PRIMARY KEY,
    company_id INT NOT NULL REFERENCES COMPANY(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    role VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX idx_employee_company_id ON EMPLOYEE(company_id);

-- Table: POSITION
CREATE TABLE POSITION (
    id SERIAL PRIMARY KEY,
    company_id INT NOT NULL REFERENCES COMPANY(id) ON DELETE CASCADE,
    interview_flow_id INT REFERENCES INTERVIEW_FLOW(id) ON DELETE SET NULL,
    title VARCHAR(255) NOT NULL,
    status VARCHAR(50),
    is_visible BOOLEAN DEFAULT TRUE,
    location VARCHAR(255),
    description TEXT,
    application_deadline DATE,
    salary_min NUMERIC(12, 2),
    salary_max NUMERIC(12, 2),
    employment_type VARCHAR(50)
);

CREATE INDEX idx_position_company_id ON POSITION(company_id);
CREATE INDEX idx_position_interview_flow_id ON POSITION(interview_flow_id);
CREATE INDEX idx_position_title ON POSITION(title);
CREATE INDEX idx_position_status_visible ON POSITION(status, is_visible);

-- Table: REQUIREMENT
CREATE TABLE REQUIREMENT (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL
);

-- Table: POSITION_REQUIREMENT
CREATE TABLE POSITION_REQUIREMENT (
    position_id INT NOT NULL REFERENCES POSITION(id) ON DELETE CASCADE,
    requirement_id INT NOT NULL REFERENCES REQUIREMENT(id) ON DELETE CASCADE,
    PRIMARY KEY (position_id, requirement_id)
);

CREATE INDEX idx_position_requirement_position_id ON POSITION_REQUIREMENT(position_id);
CREATE INDEX idx_position_requirement_requirement_id ON POSITION_REQUIREMENT(requirement_id);

-- Table: RESPONSIBILITY
CREATE TABLE RESPONSIBILITY (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL
);

-- Table: POSITION_RESPONSIBILITY
CREATE TABLE POSITION_RESPONSIBILITY (
    position_id INT NOT NULL REFERENCES POSITION(id) ON DELETE CASCADE,
    responsibility_id INT NOT NULL REFERENCES RESPONSIBILITY(id) ON DELETE CASCADE,
    PRIMARY KEY (position_id, responsibility_id)
);

CREATE INDEX idx_position_responsibility_position_id ON POSITION_RESPONSIBILITY(position_id);
CREATE INDEX idx_position_responsibility_responsibility_id ON POSITION_RESPONSIBILITY(responsibility_id);

-- Table: BENEFIT
CREATE TABLE BENEFIT (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL
);

-- Table: POSITION_BENEFIT
CREATE TABLE POSITION_BENEFIT (
    position_id INT NOT NULL REFERENCES POSITION(id) ON DELETE CASCADE,
    benefit_id INT NOT NULL REFERENCES BENEFIT(id) ON DELETE CASCADE,
    PRIMARY KEY (position_id, benefit_id)
);

CREATE INDEX idx_position_benefit_position_id ON POSITION_BENEFIT(position_id);
CREATE INDEX idx_position_benefit_benefit_id ON POSITION_BENEFIT(benefit_id);

-- Table: CONTACT_INFO
CREATE TABLE CONTACT_INFO (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255),
    phone VARCHAR(20),
    address TEXT
);

CREATE INDEX idx_contact_info_email ON CONTACT_INFO(email);
CREATE INDEX idx_contact_info_phone ON CONTACT_INFO(phone);

-- Table: POSITION_CONTACT_INFO
CREATE TABLE POSITION_CONTACT_INFO (
    position_id INT NOT NULL REFERENCES POSITION(id) ON DELETE CASCADE,
    contact_info_id INT NOT NULL REFERENCES CONTACT_INFO(id) ON DELETE CASCADE,
    PRIMARY KEY (position_id, contact_info_id)
);

CREATE INDEX idx_position_contact_info_position_id ON POSITION_CONTACT_INFO(position_id);
CREATE INDEX idx_position_contact_info_contact_info_id ON POSITION_CONTACT_INFO(contact_info_id);

-- Table: INTERVIEW_FLOW
CREATE TABLE INTERVIEW_FLOW (
    id SERIAL PRIMARY KEY,
    description TEXT
);

CREATE INDEX idx_interview_flow_description ON INTERVIEW_FLOW(description);

-- Table: FLOW_INTERVIEW_TYPE
CREATE TABLE FLOW_INTERVIEW_TYPE (
    id SERIAL PRIMARY KEY,
    interview_flow_id INT NOT NULL REFERENCES INTERVIEW_FLOW(id) ON DELETE CASCADE,
    interview_type_id INT NOT NULL REFERENCES INTERVIEW_TYPE(id) ON DELETE CASCADE
);

CREATE INDEX idx_flow_interview_type_flow_id ON FLOW_INTERVIEW_TYPE(interview_flow_id);
CREATE INDEX idx_flow_interview_type_type_id ON FLOW_INTERVIEW_TYPE(interview_type_id);

-- Table: INTERVIEW_STEP
CREATE TABLE INTERVIEW_STEP (
    id SERIAL PRIMARY KEY,
    interview_flow_id INT NOT NULL REFERENCES INTERVIEW_FLOW(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    order_index INT NOT NULL
);

CREATE INDEX idx_interview_step_flow_id ON INTERVIEW_STEP(interview_flow_id);
CREATE INDEX idx_interview_step_flow_order ON INTERVIEW_STEP(interview_flow_id, order_index);

-- Table: INTERVIEW_TYPE
CREATE TABLE INTERVIEW_TYPE (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE INDEX idx_interview_type_name ON INTERVIEW_TYPE(name);

-- Table: CANDIDATE
CREATE TABLE CANDIDATE (
    id SERIAL PRIMARY KEY,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT
);

CREATE INDEX idx_candidate_email ON CANDIDATE(email);
CREATE INDEX idx_candidate_phone ON CANDIDATE(phone);

-- Table: APPLICATION
CREATE TABLE APPLICATION (
    id SERIAL PRIMARY KEY,
    position_id INT NOT NULL REFERENCES POSITION(id) ON DELETE CASCADE,
    candidate_id INT NOT NULL REFERENCES CANDIDATE(id) ON DELETE CASCADE,
    application_date DATE NOT NULL,
    status VARCHAR(50)
);

CREATE INDEX idx_application_position_id ON APPLICATION(position_id);
CREATE INDEX idx_application_candidate_id ON APPLICATION(candidate_id);
CREATE INDEX idx_application_status ON APPLICATION(status);

-- Table: INTERVIEW
CREATE TABLE INTERVIEW (
    id SERIAL PRIMARY KEY,
    application_id INT NOT NULL REFERENCES APPLICATION(id) ON DELETE CASCADE,
    interview_step_id INT NOT NULL REFERENCES INTERVIEW_STEP(id) ON DELETE CASCADE,
    employee_id INT REFERENCES EMPLOYEE(id) ON DELETE SET NULL,
    interview_date DATE NOT NULL,
    result VARCHAR(50),
    score INT
);

CREATE INDEX idx_interview_application_id ON INTERVIEW(application_id);
CREATE INDEX idx_interview_step_id ON INTERVIEW(interview_step_id);
CREATE INDEX idx_interview_employee_id ON INTERVIEW(employee_id);
CREATE INDEX idx_interview_date ON INTERVIEW(interview_date);

-- Table: NOTES
CREATE TABLE NOTES (
    id SERIAL PRIMARY KEY,
    application_id INT REFERENCES APPLICATION(id) ON DELETE CASCADE,
    interview_id INT REFERENCES INTERVIEW(id) ON DELETE CASCADE,
    note TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    note_type VARCHAR(50)
);

CREATE INDEX idx_notes_application_id ON NOTES(application_id);
CREATE INDEX idx_notes_interview_id ON NOTES(interview_id);
