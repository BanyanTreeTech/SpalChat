//
//  QMDefinitions.h
//  Q-municate
//
//  Created by Igor Alefirenko on 14/02/2014.
//  Copyright (c) 2014 Quickblox. All rights reserved.
//

#ifndef Q_municate_Definitions_h
#define Q_municate_Definitions_h

#define QM_TEST 0

#define QM_AUDIO_VIDEO_ENABLED 1

#define DELETING_DIALOGS_ENABLED 0

#define API_SCHOOLLIST    @"http://spalchat.com/spalchat_web_service/API/get_school_list.php?type=%@"
#define API_GRADELIST       @"http://spalchat.com/spalchat_web_service/API/get_grade_list.php"

#define API_SIGNUP          @"http://spalchat.com/spalchat_web_service/API/registration.php?parent_name=%@&phone_number=%@&is_parent=%@&device_id=%@&device_os=%@&school_id=%@&child_info=%@"


#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define $(...)  [NSSet setWithObjects:__VA_ARGS__, nil]

#define CHECK_OVERRIDE()\
@throw\
[NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]\
userInfo:nil]

/*QMContentService*/
typedef void(^QMContentProgressBlock)(float progress);
typedef void(^QMCFileUploadTaskResultBlockBlock)(QBCFileUploadTaskResult *result);
typedef void(^QMCFileDownloadTaskResultBlockBlock)(QBCFileDownloadTaskResult *result);
typedef void (^QBUUserResultBlock)(QBUUserResult *result);
typedef void (^QBAAuthResultBlock)(QBAAuthResult *result);
typedef void (^QBUUserLogInResultBlock)(QBUUserLogInResult *result);
typedef void (^QBAAuthSessionCreationResultBlock)(QBAAuthSessionCreationResult *result);
typedef void (^QBUUserPagedResultBlock)(QBUUserPagedResult *pagedResult);
typedef void (^QBMRegisterSubscriptionTaskResultBlock)(QBMRegisterSubscriptionTaskResult *result);
typedef void (^QBMUnregisterSubscriptionTaskResultBlock)(QBMUnregisterSubscriptionTaskResult *result);
typedef void (^QBDialogsPagedResultBlock)(QBDialogsPagedResult *result);
typedef void (^QBChatDialogResultBlock)(QBChatDialogResult *result);
typedef void (^QBChatHistoryMessageResultBlock)(QBChatHistoryMessageResult *result);

typedef void (^QBResultBlock)(QBResult *result);
typedef void (^QBSessionCreationBlock)(BOOL success, NSString *error);
typedef void (^QBChatResultBlock)(BOOL success);
typedef void (^QBChatRoomResultBlock)(QBChatRoom *chatRoom, NSError *error);
typedef void (^QBChatDialogHistoryBlock)(NSMutableArray *chatDialogHistoryArray, NSError *error);

//************** Segue Identifiers *************************
static NSString *const kTabBarSegueIdnetifier         = @"TabBarSegue";
static NSString *const kSplashSegueIdentifier         = @"SplashSegue";
static NSString *const kWelcomeScreenSegueIdentifier  = @"WelcomeScreenSegue";
static NSString *const kSignUpSegueIdentifier         = @"SignUpSegue";
static NSString *const kSchoolListSegueIdentifier     = @"SchoolListSegue";
static NSString *const kAddChildSegueIdentifier       = @"AddChildSegue";

static NSString *const kPhoneSegue       = @"NextInputPhoneSegue";
static NSString *const kPhoneVeriSegue       = @"NextInputVeriSegue";
static NSString *const KGoTabMainSegue       = @"GoTabMainSegue";

static NSString *const kLogInSegueSegueIdentifier     = @"LogInSegue";
static NSString *const kDetailsSegueIdentifier        = @"DetailsSegue";
static NSString *const kVideoCallSegueIdentifier      = @"VideoCallSegue";
static NSString *const kAudioCallSegueIdentifier      = @"AudioCallSegue";
static NSString *const kGoToDuringAudioCallSegueIdentifier = @"goToDuringAudioCallSegueIdentifier";
static NSString *const kGoToDuringVideoCallSegueIdentifier = @"goToDuringVideoCallSegueIdentifier";
static NSString *const kChatViewSegueIdentifier       = @"ChatViewSegue";
static NSString *const kIncomingCallIdentifier        = @"IncomingCallIdentifier";
static NSString *const kProfileSegueIdentifier        = @"ProfileSegue";
static NSString *const kCreateNewChatSegueIdentifier  = @"CreateNewChatSegue";
static NSString *const kContentPreviewSegueIdentifier = @"ContentPreviewIdentifier";
static NSString *const kGroupDetailsSegueIdentifier   = @"GroupDetailsSegue";
static NSString *const kQMAddMembersToGroupControllerSegue = @"QMAddMembersToGroupControllerSegue";

static NSString *const kSettingsCellBundleVersion = @"CFBundleVersion";


static NSString *const SSchoolListName      = @"SSchoolListName";
static NSString *const SSchoolListID        = @"SSchoolListID";

static NSString *const SGradeListName      = @"SGradeListName";
static NSString *const SGradeListID        = @"SGradeListID";

static NSString *const SignYourname         = @"SignYourname";
static NSString *const SignChildname        = @"SignChildname";
static NSString *const SignClassroomname    = @"SignClassroomname";
static NSString *const SignPhonenumber    = @"SignPhonenumber";

static NSString *const VerCode             = @"VerificationCode";
static NSString *const SignFlag             = @"SignFlag";

//******************** USER DEFAULTS KEYS *****************

static NSString *const kMailSubjectString               = @"Q-municate";
static NSString *const kMailBodyString                  = @"<a href='http://quickblox.com/'>Join us in Q-municate!</a>";

#endif
