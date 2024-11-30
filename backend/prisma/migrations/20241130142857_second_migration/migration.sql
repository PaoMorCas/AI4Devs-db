/*
  Warnings:

  - You are about to drop the `Education` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Resume` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `WorkExperience` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Education" DROP CONSTRAINT "Education_candidateId_fkey";

-- DropForeignKey
ALTER TABLE "Resume" DROP CONSTRAINT "Resume_candidateId_fkey";

-- DropForeignKey
ALTER TABLE "WorkExperience" DROP CONSTRAINT "WorkExperience_candidateId_fkey";

-- AlterTable
ALTER TABLE "Candidate" ALTER COLUMN "firstName" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "lastName" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "phone" SET DATA TYPE VARCHAR(20),
ALTER COLUMN "address" SET DATA TYPE TEXT;

-- DropTable
DROP TABLE "Education";

-- DropTable
DROP TABLE "Resume";

-- DropTable
DROP TABLE "WorkExperience";

-- CreateTable
CREATE TABLE "Company" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Employee" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "role" VARCHAR(255),
    "isActive" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Employee_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Position" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "interviewFlowId" INTEGER,
    "title" VARCHAR(255) NOT NULL,
    "status" VARCHAR(50),
    "isVisible" BOOLEAN NOT NULL DEFAULT true,
    "location" VARCHAR(255),
    "description" TEXT,
    "applicationDeadline" TIMESTAMP(3),
    "salaryMin" DOUBLE PRECISION,
    "salaryMax" DOUBLE PRECISION,
    "employmentType" VARCHAR(50),

    CONSTRAINT "Position_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Requirement" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "Requirement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PositionRequirement" (
    "positionId" INTEGER NOT NULL,
    "requirementId" INTEGER NOT NULL,

    CONSTRAINT "PositionRequirement_pkey" PRIMARY KEY ("positionId","requirementId")
);

-- CreateTable
CREATE TABLE "Responsibility" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "Responsibility_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PositionResponsibility" (
    "positionId" INTEGER NOT NULL,
    "responsibilityId" INTEGER NOT NULL,

    CONSTRAINT "PositionResponsibility_pkey" PRIMARY KEY ("positionId","responsibilityId")
);

-- CreateTable
CREATE TABLE "Benefit" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "Benefit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PositionBenefit" (
    "positionId" INTEGER NOT NULL,
    "benefitId" INTEGER NOT NULL,

    CONSTRAINT "PositionBenefit_pkey" PRIMARY KEY ("positionId","benefitId")
);

-- CreateTable
CREATE TABLE "ContactInfo" (
    "id" SERIAL NOT NULL,
    "email" VARCHAR(255),
    "phone" VARCHAR(20),
    "address" TEXT,

    CONSTRAINT "ContactInfo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PositionContactInfo" (
    "positionId" INTEGER NOT NULL,
    "contactInfoId" INTEGER NOT NULL,

    CONSTRAINT "PositionContactInfo_pkey" PRIMARY KEY ("positionId","contactInfoId")
);

-- CreateTable
CREATE TABLE "InterviewFlow" (
    "id" SERIAL NOT NULL,
    "description" TEXT,

    CONSTRAINT "InterviewFlow_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FlowInterviewType" (
    "id" SERIAL NOT NULL,
    "interviewFlowId" INTEGER NOT NULL,
    "interviewTypeId" INTEGER NOT NULL,

    CONSTRAINT "FlowInterviewType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InterviewStep" (
    "id" SERIAL NOT NULL,
    "interviewFlowId" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "orderIndex" INTEGER NOT NULL,

    CONSTRAINT "InterviewStep_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InterviewType" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT,

    CONSTRAINT "InterviewType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Application" (
    "id" SERIAL NOT NULL,
    "positionId" INTEGER NOT NULL,
    "candidateId" INTEGER NOT NULL,
    "applicationDate" TIMESTAMP(3) NOT NULL,
    "status" VARCHAR(50),

    CONSTRAINT "Application_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Interview" (
    "id" SERIAL NOT NULL,
    "applicationId" INTEGER NOT NULL,
    "interviewStepId" INTEGER NOT NULL,
    "employeeId" INTEGER,
    "interviewDate" TIMESTAMP(3) NOT NULL,
    "result" VARCHAR(50),
    "score" INTEGER,

    CONSTRAINT "Interview_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Note" (
    "id" SERIAL NOT NULL,
    "applicationId" INTEGER,
    "interviewId" INTEGER,
    "note" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "noteType" VARCHAR(50),

    CONSTRAINT "Note_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Company_name_idx" ON "Company"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_email_key" ON "Employee"("email");

-- CreateIndex
CREATE INDEX "Employee_companyId_idx" ON "Employee"("companyId");

-- CreateIndex
CREATE INDEX "Position_companyId_idx" ON "Position"("companyId");

-- CreateIndex
CREATE INDEX "Position_interviewFlowId_idx" ON "Position"("interviewFlowId");

-- CreateIndex
CREATE INDEX "Position_title_idx" ON "Position"("title");

-- CreateIndex
CREATE INDEX "Position_status_isVisible_idx" ON "Position"("status", "isVisible");

-- CreateIndex
CREATE INDEX "PositionRequirement_positionId_idx" ON "PositionRequirement"("positionId");

-- CreateIndex
CREATE INDEX "PositionRequirement_requirementId_idx" ON "PositionRequirement"("requirementId");

-- CreateIndex
CREATE INDEX "PositionResponsibility_positionId_idx" ON "PositionResponsibility"("positionId");

-- CreateIndex
CREATE INDEX "PositionResponsibility_responsibilityId_idx" ON "PositionResponsibility"("responsibilityId");

-- CreateIndex
CREATE INDEX "PositionBenefit_positionId_idx" ON "PositionBenefit"("positionId");

-- CreateIndex
CREATE INDEX "PositionBenefit_benefitId_idx" ON "PositionBenefit"("benefitId");

-- CreateIndex
CREATE INDEX "ContactInfo_email_idx" ON "ContactInfo"("email");

-- CreateIndex
CREATE INDEX "ContactInfo_phone_idx" ON "ContactInfo"("phone");

-- CreateIndex
CREATE INDEX "PositionContactInfo_positionId_idx" ON "PositionContactInfo"("positionId");

-- CreateIndex
CREATE INDEX "PositionContactInfo_contactInfoId_idx" ON "PositionContactInfo"("contactInfoId");

-- CreateIndex
CREATE INDEX "InterviewFlow_description_idx" ON "InterviewFlow"("description");

-- CreateIndex
CREATE INDEX "FlowInterviewType_interviewFlowId_idx" ON "FlowInterviewType"("interviewFlowId");

-- CreateIndex
CREATE INDEX "FlowInterviewType_interviewTypeId_idx" ON "FlowInterviewType"("interviewTypeId");

-- CreateIndex
CREATE INDEX "InterviewStep_interviewFlowId_idx" ON "InterviewStep"("interviewFlowId");

-- CreateIndex
CREATE INDEX "InterviewStep_interviewFlowId_orderIndex_idx" ON "InterviewStep"("interviewFlowId", "orderIndex");

-- CreateIndex
CREATE INDEX "InterviewType_name_idx" ON "InterviewType"("name");

-- CreateIndex
CREATE INDEX "Application_positionId_idx" ON "Application"("positionId");

-- CreateIndex
CREATE INDEX "Application_candidateId_idx" ON "Application"("candidateId");

-- CreateIndex
CREATE INDEX "Application_status_idx" ON "Application"("status");

-- CreateIndex
CREATE INDEX "Interview_applicationId_idx" ON "Interview"("applicationId");

-- CreateIndex
CREATE INDEX "Interview_interviewStepId_idx" ON "Interview"("interviewStepId");

-- CreateIndex
CREATE INDEX "Interview_employeeId_idx" ON "Interview"("employeeId");

-- CreateIndex
CREATE INDEX "Interview_interviewDate_idx" ON "Interview"("interviewDate");

-- CreateIndex
CREATE INDEX "Note_applicationId_idx" ON "Note"("applicationId");

-- CreateIndex
CREATE INDEX "Note_interviewId_idx" ON "Note"("interviewId");

-- CreateIndex
CREATE INDEX "Candidate_email_idx" ON "Candidate"("email");

-- CreateIndex
CREATE INDEX "Candidate_phone_idx" ON "Candidate"("phone");

-- AddForeignKey
ALTER TABLE "Employee" ADD CONSTRAINT "Employee_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_interviewFlowId_fkey" FOREIGN KEY ("interviewFlowId") REFERENCES "InterviewFlow"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PositionRequirement" ADD CONSTRAINT "PositionRequirement_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "Position"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PositionRequirement" ADD CONSTRAINT "PositionRequirement_requirementId_fkey" FOREIGN KEY ("requirementId") REFERENCES "Requirement"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PositionResponsibility" ADD CONSTRAINT "PositionResponsibility_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "Position"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PositionResponsibility" ADD CONSTRAINT "PositionResponsibility_responsibilityId_fkey" FOREIGN KEY ("responsibilityId") REFERENCES "Responsibility"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PositionBenefit" ADD CONSTRAINT "PositionBenefit_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "Position"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PositionBenefit" ADD CONSTRAINT "PositionBenefit_benefitId_fkey" FOREIGN KEY ("benefitId") REFERENCES "Benefit"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PositionContactInfo" ADD CONSTRAINT "PositionContactInfo_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "Position"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PositionContactInfo" ADD CONSTRAINT "PositionContactInfo_contactInfoId_fkey" FOREIGN KEY ("contactInfoId") REFERENCES "ContactInfo"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FlowInterviewType" ADD CONSTRAINT "FlowInterviewType_interviewFlowId_fkey" FOREIGN KEY ("interviewFlowId") REFERENCES "InterviewFlow"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FlowInterviewType" ADD CONSTRAINT "FlowInterviewType_interviewTypeId_fkey" FOREIGN KEY ("interviewTypeId") REFERENCES "InterviewType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InterviewStep" ADD CONSTRAINT "InterviewStep_interviewFlowId_fkey" FOREIGN KEY ("interviewFlowId") REFERENCES "InterviewFlow"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "Position"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_candidateId_fkey" FOREIGN KEY ("candidateId") REFERENCES "Candidate"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_interviewStepId_fkey" FOREIGN KEY ("interviewStepId") REFERENCES "InterviewStep"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_employeeId_fkey" FOREIGN KEY ("employeeId") REFERENCES "Employee"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Note" ADD CONSTRAINT "Note_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Note" ADD CONSTRAINT "Note_interviewId_fkey" FOREIGN KEY ("interviewId") REFERENCES "Interview"("id") ON DELETE CASCADE ON UPDATE CASCADE;
