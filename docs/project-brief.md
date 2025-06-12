# **Project Brief**

* **Project:** FaceCheckIn Employee
* **Creation Date:** June 12, 2025
* **Version:** 1.1 (Standardized to template)

### **Introduction / Problem Statement**

This project aims to build a real-time facial recognition time-keeping application for employees. Traditional check-in methods at the company, particularly fingerprint-based ones, are often time-consuming, can cause congestion, and diminish the employee experience. This project was created to provide a faster and more seamless solution.

### **Vision & Goals**

* **Vision:** To create a modern work environment where the check-in process is invisible and instantaneous.
* **Goals:**
    1.  **Enhance Check-in Efficiency:** Reduce the average check-in time per employee to under 3 seconds.
    2.  **High Adoption Rate:** Achieve > 95% of daily check-ins via the new system.
    3.  **MVP Completion:** Deploy the MVP version within a 2-week timeframe.

### **Target Audience / Users**

1.  **Primary Users:** All company employees.
2.  **Administrative Users:** The Human Resources (HR) Department and Management (who will use a separate admin web system).

### **Key Features / Scope (High-Level Ideas for MVP)**

* A Flutter application running on a fixed device (e.g., a tablet).
* An always-on camera feature that continuously streams video to the backend for processing.
* Display of a simple greeting after a successful recognition.
* Display of a failure notification when recognition is unsuccessful.

### **Post MVP Features / Scope and Ideas**

* Automatic door opening on successful check-in.
* Recognition of users as they simply walk by the camera area ("walk-by" mode).
* Backup check-in methods (e.g., PIN entry, QR code).
* A "Not me" button to report recognition errors.

### **Known Technical Constraints or Preferences**

* **Constraints:**
    * The MVP must be completed within 2 weeks.
    * The frontend must be built with Flutter.
* **Initial Architectural Preferences:**
    * The system must be designed to handle a continuous video stream from the frontend device rather than processing individual snapshots.
* **Risks:**
    * The stability, cost, or terms of a third-party facial recognition AI service could change, impacting the project's operation.

### **Relevant Research (Optional)**

* None at this time.

### **PM Prompt**
To: Product Manager (John),

This is the Project Brief for "FaceCheckIn Employee". This document contains the agreed-upon vision, goals, scope, and constraints. Please use this document as the input to begin creating the detailed "Product Requirements Document (PRD)", including User Stories and Acceptance Criteria.

---
### **Appendix: Additional Information**
*Note: This detailed information is to be used by the Product Manager to build the PRD.*
* **Stakeholders:**
    * Project Sponsor / Product Owner
    * Development Team
    * Human Resources (HR) Dept.
    * Company Employees
* **Success Metrics:**
    * Average Check-in Time: < 3 seconds.
    * Adoption Rate: > 95%.
    * On-Time Completion: Within 2 weeks.
    * Employee Satisfaction: > 4.5/5 stars.