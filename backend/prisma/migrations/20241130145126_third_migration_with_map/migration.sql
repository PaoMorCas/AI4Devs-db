/*
  Warnings:

  - You are about to drop the `Application` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Benefit` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Candidate` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Company` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ContactInfo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Employee` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `FlowInterviewType` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Interview` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `InterviewFlow` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `InterviewStep` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `InterviewType` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Note` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Position` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PositionBenefit` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PositionContactInfo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PositionRequirement` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PositionResponsibility` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Requirement` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Responsibility` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Application" DROP CONSTRAINT "Application_candidateId_fkey";

-- DropForeignKey
ALTER TABLE "Application" DROP CONSTRAINT "Application_positionId_fkey";

-- DropForeignKey
ALTER TABLE "Employee" DROP CONSTRAINT "Employee_companyId_fkey";

-- DropForeignKey
ALTER TABLE "FlowInterviewType" DROP CONSTRAINT "FlowInterviewType_interviewFlowId_fkey";

-- DropForeignKey
ALTER TABLE "FlowInterviewType" DROP CONSTRAINT "FlowInterviewType_interviewTypeId_fkey";

-- DropForeignKey
ALTER TABLE "Interview" DROP CONSTRAINT "Interview_applicationId_fkey";

-- DropForeignKey
ALTER TABLE "Interview" DROP CONSTRAINT "Interview_employeeId_fkey";

-- DropForeignKey
ALTER TABLE "Interview" DROP CONSTRAINT "Interview_interviewStepId_fkey";

-- DropForeignKey
ALTER TABLE "InterviewStep" DROP CONSTRAINT "InterviewStep_interviewFlowId_fkey";

-- DropForeignKey
ALTER TABLE "Note" DROP CONSTRAINT "Note_applicationId_fkey";

-- DropForeignKey
ALTER TABLE "Note" DROP CONSTRAINT "Note_interviewId_fkey";

-- DropForeignKey
ALTER TABLE "Position" DROP CONSTRAINT "Position_companyId_fkey";

-- DropForeignKey
ALTER TABLE "Position" DROP CONSTRAINT "Position_interviewFlowId_fkey";

-- DropForeignKey
ALTER TABLE "PositionBenefit" DROP CONSTRAINT "PositionBenefit_benefitId_fkey";

-- DropForeignKey
ALTER TABLE "PositionBenefit" DROP CONSTRAINT "PositionBenefit_positionId_fkey";

-- DropForeignKey
ALTER TABLE "PositionContactInfo" DROP CONSTRAINT "PositionContactInfo_contactInfoId_fkey";

-- DropForeignKey
ALTER TABLE "PositionContactInfo" DROP CONSTRAINT "PositionContactInfo_positionId_fkey";

-- DropForeignKey
ALTER TABLE "PositionRequirement" DROP CONSTRAINT "PositionRequirement_positionId_fkey";

-- DropForeignKey
ALTER TABLE "PositionRequirement" DROP CONSTRAINT "PositionRequirement_requirementId_fkey";

-- DropForeignKey
ALTER TABLE "PositionResponsibility" DROP CONSTRAINT "PositionResponsibility_positionId_fkey";

-- DropForeignKey
ALTER TABLE "PositionResponsibility" DROP CONSTRAINT "PositionResponsibility_responsibilityId_fkey";

-- DropTable
DROP TABLE "Application";

-- DropTable
DROP TABLE "Benefit";

-- DropTable
DROP TABLE "Candidate";

-- DropTable
DROP TABLE "Company";

-- DropTable
DROP TABLE "ContactInfo";

-- DropTable
DROP TABLE "Employee";

-- DropTable
DROP TABLE "FlowInterviewType";

-- DropTable
DROP TABLE "Interview";

-- DropTable
DROP TABLE "InterviewFlow";

-- DropTable
DROP TABLE "InterviewStep";

-- DropTable
DROP TABLE "InterviewType";

-- DropTable
DROP TABLE "Note";

-- DropTable
DROP TABLE "Position";

-- DropTable
DROP TABLE "PositionBenefit";

-- DropTable
DROP TABLE "PositionContactInfo";

-- DropTable
DROP TABLE "PositionRequirement";

-- DropTable
DROP TABLE "PositionResponsibility";

-- DropTable
DROP TABLE "Requirement";

-- DropTable
DROP TABLE "Responsibility";

-- CreateTable
CREATE TABLE "company" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT,

    CONSTRAINT "company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "employee" (
    "id" SERIAL NOT NULL,
    "company_id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "role" VARCHAR(255),
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "employee_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "position" (
    "id" SERIAL NOT NULL,
    "company_id" INTEGER NOT NULL,
    "interview_flow_id" INTEGER,
    "title" VARCHAR(255) NOT NULL,
    "status" VARCHAR(50),
    "is_visible" BOOLEAN NOT NULL DEFAULT true,
    "location" VARCHAR(255),
    "description" TEXT,
    "application_deadline" TIMESTAMP(3),
    "salary_min" DOUBLE PRECISION,
    "salary_max" DOUBLE PRECISION,
    "employment_type" VARCHAR(50),

    CONSTRAINT "position_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "requirement" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "requirement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "position_requirement" (
    "position_id" INTEGER NOT NULL,
    "requirement_id" INTEGER NOT NULL,

    CONSTRAINT "position_requirement_pkey" PRIMARY KEY ("position_id","requirement_id")
);

-- CreateTable
CREATE TABLE "responsibility" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "responsibility_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "position_responsibility" (
    "position_id" INTEGER NOT NULL,
    "responsibility_id" INTEGER NOT NULL,

    CONSTRAINT "position_responsibility_pkey" PRIMARY KEY ("position_id","responsibility_id")
);

-- CreateTable
CREATE TABLE "benefit" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "benefit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "position_benefit" (
    "position_id" INTEGER NOT NULL,
    "benefit_id" INTEGER NOT NULL,

    CONSTRAINT "position_benefit_pkey" PRIMARY KEY ("position_id","benefit_id")
);

-- CreateTable
CREATE TABLE "contact_info" (
    "id" SERIAL NOT NULL,
    "email" VARCHAR(255),
    "phone" VARCHAR(20),
    "address" TEXT,

    CONSTRAINT "contact_info_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "position_contact_info" (
    "position_id" INTEGER NOT NULL,
    "contact_info_id" INTEGER NOT NULL,

    CONSTRAINT "position_contact_info_pkey" PRIMARY KEY ("position_id","contact_info_id")
);

-- CreateTable
CREATE TABLE "interview_flow" (
    "id" SERIAL NOT NULL,
    "description" TEXT,

    CONSTRAINT "interview_flow_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "flow_interview_type" (
    "id" SERIAL NOT NULL,
    "interview_flow_id" INTEGER NOT NULL,
    "interview_type_id" INTEGER NOT NULL,

    CONSTRAINT "flow_interview_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "interview_step" (
    "id" SERIAL NOT NULL,
    "interview_flow_id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "order_index" INTEGER NOT NULL,

    CONSTRAINT "interview_step_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "interview_type" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT,

    CONSTRAINT "interview_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "candidate" (
    "id" SERIAL NOT NULL,
    "first_name" VARCHAR(255) NOT NULL,
    "last_name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(20),
    "address" TEXT,

    CONSTRAINT "candidate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "application" (
    "id" SERIAL NOT NULL,
    "position_id" INTEGER NOT NULL,
    "candidate_id" INTEGER NOT NULL,
    "application_date" TIMESTAMP(3) NOT NULL,
    "status" VARCHAR(50),

    CONSTRAINT "application_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "interview" (
    "id" SERIAL NOT NULL,
    "application_id" INTEGER NOT NULL,
    "interview_step_id" INTEGER NOT NULL,
    "employee_id" INTEGER,
    "interview_date" TIMESTAMP(3) NOT NULL,
    "result" VARCHAR(50),
    "score" INTEGER,

    CONSTRAINT "interview_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notes" (
    "id" SERIAL NOT NULL,
    "application_id" INTEGER,
    "interview_id" INTEGER,
    "note" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "note_type" VARCHAR(50),

    CONSTRAINT "notes_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "company_name_idx" ON "company"("name");

-- CreateIndex
CREATE UNIQUE INDEX "employee_email_key" ON "employee"("email");

-- CreateIndex
CREATE INDEX "employee_company_id_idx" ON "employee"("company_id");

-- CreateIndex
CREATE INDEX "position_company_id_idx" ON "position"("company_id");

-- CreateIndex
CREATE INDEX "position_interview_flow_id_idx" ON "position"("interview_flow_id");

-- CreateIndex
CREATE INDEX "position_title_idx" ON "position"("title");

-- CreateIndex
CREATE INDEX "position_status_is_visible_idx" ON "position"("status", "is_visible");

-- CreateIndex
CREATE INDEX "position_requirement_position_id_idx" ON "position_requirement"("position_id");

-- CreateIndex
CREATE INDEX "position_requirement_requirement_id_idx" ON "position_requirement"("requirement_id");

-- CreateIndex
CREATE INDEX "position_responsibility_position_id_idx" ON "position_responsibility"("position_id");

-- CreateIndex
CREATE INDEX "position_responsibility_responsibility_id_idx" ON "position_responsibility"("responsibility_id");

-- CreateIndex
CREATE INDEX "position_benefit_position_id_idx" ON "position_benefit"("position_id");

-- CreateIndex
CREATE INDEX "position_benefit_benefit_id_idx" ON "position_benefit"("benefit_id");

-- CreateIndex
CREATE INDEX "contact_info_email_idx" ON "contact_info"("email");

-- CreateIndex
CREATE INDEX "contact_info_phone_idx" ON "contact_info"("phone");

-- CreateIndex
CREATE INDEX "position_contact_info_position_id_idx" ON "position_contact_info"("position_id");

-- CreateIndex
CREATE INDEX "position_contact_info_contact_info_id_idx" ON "position_contact_info"("contact_info_id");

-- CreateIndex
CREATE INDEX "interview_flow_description_idx" ON "interview_flow"("description");

-- CreateIndex
CREATE INDEX "flow_interview_type_interview_flow_id_idx" ON "flow_interview_type"("interview_flow_id");

-- CreateIndex
CREATE INDEX "flow_interview_type_interview_type_id_idx" ON "flow_interview_type"("interview_type_id");

-- CreateIndex
CREATE INDEX "interview_step_interview_flow_id_idx" ON "interview_step"("interview_flow_id");

-- CreateIndex
CREATE INDEX "interview_step_interview_flow_id_order_index_idx" ON "interview_step"("interview_flow_id", "order_index");

-- CreateIndex
CREATE INDEX "interview_type_name_idx" ON "interview_type"("name");

-- CreateIndex
CREATE UNIQUE INDEX "candidate_email_key" ON "candidate"("email");

-- CreateIndex
CREATE INDEX "candidate_email_idx" ON "candidate"("email");

-- CreateIndex
CREATE INDEX "candidate_phone_idx" ON "candidate"("phone");

-- CreateIndex
CREATE INDEX "application_position_id_idx" ON "application"("position_id");

-- CreateIndex
CREATE INDEX "application_candidate_id_idx" ON "application"("candidate_id");

-- CreateIndex
CREATE INDEX "application_status_idx" ON "application"("status");

-- CreateIndex
CREATE INDEX "interview_application_id_idx" ON "interview"("application_id");

-- CreateIndex
CREATE INDEX "interview_interview_step_id_idx" ON "interview"("interview_step_id");

-- CreateIndex
CREATE INDEX "interview_employee_id_idx" ON "interview"("employee_id");

-- CreateIndex
CREATE INDEX "interview_interview_date_idx" ON "interview"("interview_date");

-- CreateIndex
CREATE INDEX "notes_application_id_idx" ON "notes"("application_id");

-- CreateIndex
CREATE INDEX "notes_interview_id_idx" ON "notes"("interview_id");

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "employee_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "position" ADD CONSTRAINT "position_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "position" ADD CONSTRAINT "position_interview_flow_id_fkey" FOREIGN KEY ("interview_flow_id") REFERENCES "interview_flow"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "position_requirement" ADD CONSTRAINT "position_requirement_position_id_fkey" FOREIGN KEY ("position_id") REFERENCES "position"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "position_requirement" ADD CONSTRAINT "position_requirement_requirement_id_fkey" FOREIGN KEY ("requirement_id") REFERENCES "requirement"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "position_responsibility" ADD CONSTRAINT "position_responsibility_position_id_fkey" FOREIGN KEY ("position_id") REFERENCES "position"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "position_responsibility" ADD CONSTRAINT "position_responsibility_responsibility_id_fkey" FOREIGN KEY ("responsibility_id") REFERENCES "responsibility"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "position_benefit" ADD CONSTRAINT "position_benefit_position_id_fkey" FOREIGN KEY ("position_id") REFERENCES "position"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "position_benefit" ADD CONSTRAINT "position_benefit_benefit_id_fkey" FOREIGN KEY ("benefit_id") REFERENCES "benefit"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "position_contact_info" ADD CONSTRAINT "position_contact_info_position_id_fkey" FOREIGN KEY ("position_id") REFERENCES "position"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "position_contact_info" ADD CONSTRAINT "position_contact_info_contact_info_id_fkey" FOREIGN KEY ("contact_info_id") REFERENCES "contact_info"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "flow_interview_type" ADD CONSTRAINT "flow_interview_type_interview_flow_id_fkey" FOREIGN KEY ("interview_flow_id") REFERENCES "interview_flow"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "flow_interview_type" ADD CONSTRAINT "flow_interview_type_interview_type_id_fkey" FOREIGN KEY ("interview_type_id") REFERENCES "interview_type"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "interview_step" ADD CONSTRAINT "interview_step_interview_flow_id_fkey" FOREIGN KEY ("interview_flow_id") REFERENCES "interview_flow"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "application" ADD CONSTRAINT "application_position_id_fkey" FOREIGN KEY ("position_id") REFERENCES "position"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "application" ADD CONSTRAINT "application_candidate_id_fkey" FOREIGN KEY ("candidate_id") REFERENCES "candidate"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "interview" ADD CONSTRAINT "interview_application_id_fkey" FOREIGN KEY ("application_id") REFERENCES "application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "interview" ADD CONSTRAINT "interview_interview_step_id_fkey" FOREIGN KEY ("interview_step_id") REFERENCES "interview_step"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "interview" ADD CONSTRAINT "interview_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "employee"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notes" ADD CONSTRAINT "notes_application_id_fkey" FOREIGN KEY ("application_id") REFERENCES "application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notes" ADD CONSTRAINT "notes_interview_id_fkey" FOREIGN KEY ("interview_id") REFERENCES "interview"("id") ON DELETE CASCADE ON UPDATE CASCADE;
