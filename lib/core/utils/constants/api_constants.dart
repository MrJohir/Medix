const String baseUrl = "http://72.60.199.45:3000/api";
const String aIbaseUrl = "http://72.60.199.45:8000/api/v1/";

// User management endpoints
const String getAllUsersEndpoint = "/admin/user"; // Original endpoint
const String getUserByIdEndpoint = "/admin/user"; // Will append /{id}
const String createUserEndpoint = "/admin/user"; // Create new user
const String deleteUserEndpoint = "/admin/user"; // Will append /{id}
const String updateUserEndpoint = "/admin/approve"; // Will append /{id}

// Authentication endpoints

const String forgetpasswordEndpoint = '/auth/forget-password';

// Dashboard endpoints
const String dashboardSummaryEndpoint = "/admin";
const String recentActivityEndpoint = "/admin/recentActivity";

// User recent activity endpoint
const String userRecentActivityEndpoint = "/user/recent-activity";

// SOP endpoints
const String getAllSOPsEndpoint = "/sop";
const String getSOPByIdEndpoint = "/sop"; // Will append /{id}
const String createSOPEndpoint = "/sop"; // Create new SOP
const String updateSOPEndpoint = "/sop"; // Will append /{id}
const String deleteSOPEndpoint = "/sop"; // Will append /{id}

// Report endpoints
const String createReportEndpoint = "/report";
const String getReportByIdEndpoint = "/report"; // Will append /{id}

// Medicine endpoints
const String createMedicineEndpoint = "/medicine";
const String getMedicineEndpoint = "/medicine";

///  AI endpoints
const String chatAIEndpoint = "triage/chat";
const String calculateEndpoint = "calculate";
