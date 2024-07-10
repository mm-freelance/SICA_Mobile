class AppConstants {
  static var noInternetMsg = "Application requires network to proceed";
  static String baseURL = "http://68.178.168.28:8069";
  static String verifyOtp = "/otp/verify";
  static String login = "/api/get_login_otp";
  static String memberDetails = "/get/member_details";
  static String socialLinks = "/post/member_social_links";
  static String updateMember = "/post/member_details";
  static String createProject = "/create/work_details";
  static String updateProject = "/update/work_details";
  static String deleteProject = "/delete/work_details";
  static String getallMember = "/get/all/member_details";
  static String createJobSeeker = "/create/job_seeker";
  static String getJobProvider = "/get/member/job_provider";
  static String getApprovalList = "/gat/dop/pending/shooting_approval";
  static String getJobSeeker = "/get/member/job_seeker";
  static String getShootingUpdates = "/gat/member/update_shooting";
  static String getMatchJobSeeker = "/get/all/match_job_seeker";
  //job_seeker
  static String addJobProvider = "/create/job_provider";
  static String createPayment = "/create/razorpay_order";
  static String getEventPayment = "/get/event/payment_link";
  static String getCategories = "/get/all/discuss_category";
  static String discussionTopic = "/get/all/discussion_topic";
  static String createTopic = "/create/discussion_topic";
  static String updateTopic = "/update/discussion_topic";
  static String deleteTopic = "/delete/discussion_topic";
  static String createComment = "/create/discussion_comment";
  static String updateComment = "/update/discussion_comment";
  static String createShooting = "/create/update_shooting";
  static String createDop = "/create/shooting_dop";
  static String getShootingImages =
      "/get/shooting_image?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261";
  static String getShootingdop = "/get/member/shooting_dop";
  static String getShooting = "/get/all/shooting_details";
  static String medium = "/get/all/medium";
  static String getBanners = "/get/mobile_photo";
  static String getReasons = "/get/all/grievance_reason";
  static String createGrievance = "/create/grievance_report";
  static String createAssociate = "/create/shooting_associate";
  static String getApproval = "/get/all/shooting_dop_approval";
  static String getProjectTitle = "/get/title/shooting_details";
  static String updateApproval = "/post/approve/dop/shooting";
  static String techTalk =
      "/get/tech/talk?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261";
  static String newsApi =
      "/get/sica/news?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261";
  static String blogsApi =
      "/get/sica/blog?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261";
  static String getMedium =
      "get/all/medium?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261";
  static String getEvents =
      "/get/all/events?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261";
  static String getEventsCategory =
      "/get/all/category/events?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261";
  static String getCategory =
      "/get/all/event/category?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261";
  static String vendors = "/get/spd/category";
  static String subVendors = "/get/spd/sub/category";
  static String products = "/get/spd/sub/category/product";
  static String createShootingReason = "/create/daily_shooting_update";
  static String galleryCat =
      "/get/all/gallery/category?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261";
  static String galleryData = "/get/gallery";
  static String getJobsPost = "/get/job_post";
  static String getSkills = "/get/skills";
  static String bookEventStatus = "/event/payment/callback";
  static String getVendorsImages =
      "/get/spd/banner?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261";
  static String getGalleryCategory =
      "/get/all/gallery/category?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261";
     static String getChildComment ="/get/topic/child_comments";
      static String createChildComment ="/create/child/discussion_comment";
       static String updateChildComment ="/update/child/discussion_comment";
}
