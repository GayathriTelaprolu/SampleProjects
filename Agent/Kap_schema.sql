-- MySQL dump 10.13  Distrib 9.0.1, for macos13.7 (arm64)
--
-- Host: localhost    Database: Kap
-- ------------------------------------------------------
-- Server version	9.0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `_Archive_CalendarOffDates`
--

DROP TABLE IF EXISTS `_Archive_CalendarOffDates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_CalendarOffDates` (
  `calendarId` int unsigned NOT NULL COMMENT 'Calendar that requires specific off dates from scheduled tasks',
  `calendarOffDateRepeatTypeId` tinyint unsigned NOT NULL DEFAULT '1',
  `offDate` date NOT NULL COMMENT 'specific off date requested from scheduled tasks',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`calendarId`,`calendarOffDateRepeatTypeId`,`offDate`),
  KEY `FK_CalendarOffDateRepeatTypes_calendarOffDateRepeatTypeId` (`calendarOffDateRepeatTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Specific off dates requested from having tasks by Calendar';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_Calendars`
--

DROP TABLE IF EXISTS `_Archive_Calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_Calendars` (
  `calendarId` int unsigned NOT NULL COMMENT 'surrogate primary key',
  `personId` int unsigned NOT NULL COMMENT 'PersonAccount that owns the Calendar',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`calendarId`),
  KEY `FK_PersonAccounts_personId` (`personId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Container to organize a collection of PersonEvents';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_EnrollmentDetailCalendars`
--

DROP TABLE IF EXISTS `_Archive_EnrollmentDetailCalendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_EnrollmentDetailCalendars` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetail that owns the assigned Calendar',
  `calendarId` int unsigned NOT NULL COMMENT 'Calendar assigned to the EnrollmentDetail',
  `startDate` date NOT NULL COMMENT 'date the Calendar starts',
  `endDate` date NOT NULL COMMENT 'date the Calendar ends',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`enrollmentDetailId`),
  UNIQUE KEY `UQ_calendarId` (`calendarId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Ties a single EnrollmentDetail to a single Calendar';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_EnrollmentDetailDownloads`
--

DROP TABLE IF EXISTS `_Archive_EnrollmentDetailDownloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_EnrollmentDetailDownloads` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'Enrollment detail that was downloaded',
  `userAgentId` int NOT NULL COMMENT 'User agent Id',
  `ip` int unsigned NOT NULL DEFAULT '0' COMMENT 'IP address',
  `downloadCount` tinyint unsigned DEFAULT '0' COMMENT 'Count of successful download attempts',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`enrollmentDetailId`,`userAgentId`,`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores the count of downloads of an offline offeringDetail';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_EnrollmentDetailNodePoints`
--

DROP TABLE IF EXISTS `_Archive_EnrollmentDetailNodePoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_EnrollmentDetailNodePoints` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetail that has points assigned to a Node',
  `nodeId` int unsigned NOT NULL COMMENT 'Node with points assigned',
  `totalPoints` int unsigned NOT NULL COMMENT 'total points scored on the Node by the EnrollmentDetail',
  `totalPointsPossible` int unsigned NOT NULL COMMENT 'total points possible for the Node by the EnrollmentDetail',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`enrollmentDetailId`,`nodeId`),
  KEY `FK_Nodes_nodeId` (`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Points scored and possible for Nodes by EnrollmentDetail';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_EnrollmentDetailNodeQuestionStatistics`
--

DROP TABLE IF EXISTS `_Archive_EnrollmentDetailNodeQuestionStatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_EnrollmentDetailNodeQuestionStatistics` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'the enrollmentDetailId for these node stats',
  `nodeId` int unsigned NOT NULL COMMENT 'node source for the questions',
  `questionId` int unsigned NOT NULL COMMENT 'question that is assigned to node',
  `points` int unsigned NOT NULL COMMENT 'points scored for the question',
  `pointsPossible` int unsigned NOT NULL COMMENT 'point possible for the question',
  `secondsElapsed` smallint unsigned NOT NULL COMMENT 'seconds elapsed during most recent attempt',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`enrollmentDetailId`,`nodeId`,`questionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='stores stats for questions answered within a node';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_EnrollmentDetailNodeStatistics`
--

DROP TABLE IF EXISTS `_Archive_EnrollmentDetailNodeStatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_EnrollmentDetailNodeStatistics` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'the enrollmentDetailId for these node stats',
  `nodeId` int unsigned NOT NULL COMMENT 'node source for the questions',
  `accruedSeconds` int unsigned NOT NULL COMMENT 'aggregate time for node and its children',
  `questionAccruedSeconds` int unsigned NOT NULL COMMENT 'aggregate time for node questions and child node questions',
  `childrenComplete` smallint unsigned NOT NULL COMMENT 'count of completed content for self plus children',
  `answeredCount` int unsigned NOT NULL COMMENT 'number of questions answered in a node',
  `incorrectCount` int unsigned NOT NULL COMMENT 'number of questions answered incorrectly in a node',
  `points` int unsigned NOT NULL COMMENT 'points achieved for questions answered in a node',
  `pointsPossible` int unsigned NOT NULL COMMENT 'points possible for questions answered in a node',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`enrollmentDetailId`,`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='stores sum of stats for questions answered within a node';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_EnrollmentDetailNodeStatus`
--

DROP TABLE IF EXISTS `_Archive_EnrollmentDetailNodeStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_EnrollmentDetailNodeStatus` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetail that viewed a Node',
  `nodeId` int unsigned NOT NULL COMMENT 'Node viewed',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`enrollmentDetailId`,`nodeId`),
  KEY `FK_Nodes_nodeId` (`nodeId`),
  KEY `IX_updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='The viewed Nodes by EnrollmentDetail';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_EnrollmentDetailNodeTimes`
--

DROP TABLE IF EXISTS `_Archive_EnrollmentDetailNodeTimes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_EnrollmentDetailNodeTimes` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetail that accumulated time in a Node',
  `nodeId` int unsigned NOT NULL COMMENT 'Node in which the time was accumulated',
  `accumulatedAt` datetime NOT NULL COMMENT 'The date and hour the time was accumulated for an EnrollmentDetail in a Node',
  `seconds` mediumint unsigned NOT NULL COMMENT 'Time in seconds accumulated by an EnrollmentDetail in a Node on a given date',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`enrollmentDetailId`,`nodeId`,`accumulatedAt`),
  KEY `FK_Nodes_nodeId` (`nodeId`),
  KEY `IX_enrollmentDetailId_accumulatedAt` (`enrollmentDetailId`,`accumulatedAt`),
  KEY `IX_updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='The time spent per day by EnrollmentDetail and Node';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_EnrollmentDetails`
--

DROP TABLE IF EXISTS `_Archive_EnrollmentDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_EnrollmentDetails` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'surrogate primary key',
  `enrollmentId` int unsigned NOT NULL COMMENT 'The Enrollment for these OfferingDetailNodeRoot instances',
  `offeringDetailId` int unsigned NOT NULL COMMENT 'The OfferingDetail in this Enrollment',
  `lastNodeViewed` int unsigned DEFAULT NULL COMMENT 'last viewed Node',
  `lastNodeViewedAt` timestamp NULL DEFAULT NULL COMMENT 'timestamp for the last viewed Node',
  `score` tinyint unsigned DEFAULT NULL COMMENT 'The score for this completed OfferingDetailNodeRoot instance',
  `isLocked` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether or not this EnrollmentDetail is locked from launching',
  `startedAt` timestamp NULL DEFAULT NULL COMMENT 'The time in which the OfferingDetailNodeRoot instance of this Enrollment began',
  `completedAt` timestamp NULL DEFAULT NULL COMMENT 'The time in which the OfferingDetailNodeRoot instance of this Enrollment was completed',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`enrollmentDetailId`),
  KEY `FK_Enrollments_enrollmentId` (`enrollmentId`),
  KEY `FK_OfferingDetails_offeringDetailId` (`offeringDetailId`),
  KEY `FK_Nodes_lastNodeViewed` (`lastNodeViewed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='The OfferingDetailNodeRoot an Enrollment contains';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_EnrollmentDetailTokens`
--

DROP TABLE IF EXISTS `_Archive_EnrollmentDetailTokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_EnrollmentDetailTokens` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetailId detail of the token',
  `token` char(32) NOT NULL COMMENT 'token for providing enrollment Identity',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`enrollmentDetailId`),
  UNIQUE KEY `UQ_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores tokens for autorizing to sync offline tests';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_Enrollments`
--

DROP TABLE IF EXISTS `_Archive_Enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_Enrollments` (
  `enrollmentId` int unsigned NOT NULL COMMENT 'surrogate primary key',
  `personId` int unsigned NOT NULL COMMENT 'The Person that owns the Enrollment',
  `offeringId` int unsigned NOT NULL COMMENT 'The Offering that the Person is enrolled in',
  `personAssignmentId` int unsigned NOT NULL COMMENT 'PersonOffering for the Enrollment',
  `startedAt` timestamp NULL DEFAULT NULL COMMENT 'The time in which this Enrollment was started',
  `affirmedAt` timestamp NULL DEFAULT NULL COMMENT 'The time in which this Enrollment was affirmed',
  `completedAt` timestamp NULL DEFAULT NULL COMMENT 'time the Enrollment was completed and just before the certificates service call',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`enrollmentId`),
  KEY `FK_PersonAccounts_personId` (`personId`),
  KEY `FK_Offerings_offeringId` (`offeringId`),
  KEY `FK_PersonAssignments_personAssignmentId` (`personAssignmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='The instance of a Person launching an Offering';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_InstructorEnrollments`
--

DROP TABLE IF EXISTS `_Archive_InstructorEnrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_InstructorEnrollments` (
  `instructorPersonId` int unsigned NOT NULL COMMENT 'instructor PersonAccount managing the Enrollments',
  `enrollmentId` int unsigned NOT NULL COMMENT 'Enrollment managed by instructor PersonAccount',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`instructorPersonId`,`enrollmentId`),
  KEY `FK_Enrollments_enrollmentId` (`enrollmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Join table between instructor PersonAccounts and Enrollments';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_PersonEvents`
--

DROP TABLE IF EXISTS `_Archive_PersonEvents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_PersonEvents` (
  `personEventId` int unsigned NOT NULL COMMENT 'surrogate primary key',
  `calendarId` int unsigned NOT NULL COMMENT 'Calendar the PersonEvent belongs to',
  `nodeId` int unsigned NOT NULL COMMENT 'task type Node for the PersonEvent',
  `startTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the PersonEvent starts',
  `durationSeconds` mediumint unsigned NOT NULL DEFAULT '0' COMMENT 'duration in seconds of the PersonEvent',
  `title` varchar(255) NOT NULL COMMENT 'title of the PersonEvent',
  `shortTitle` varchar(30) DEFAULT NULL COMMENT 'A shortened title for the PersonEvent',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`personEventId`),
  UNIQUE KEY `UQ_calendarId_nodeId` (`calendarId`,`nodeId`),
  KEY `FK_Nodes_nodeId` (`nodeId`),
  KEY `IX_calendarId_startTime_personEventId` (`calendarId`,`startTime`,`personEventId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Calendar of tasks and custom events by PersonAccount';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_PersonSecurityAnswers`
--

DROP TABLE IF EXISTS `_Archive_PersonSecurityAnswers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_PersonSecurityAnswers` (
  `personId` int unsigned NOT NULL COMMENT 'Foreign key to the PersonAccounts table',
  `securityQuestionId` tinyint unsigned NOT NULL COMMENT 'Foreign key to the SecurityQuestions table',
  `answer` char(32) NOT NULL COMMENT 'Hash of the answer to the question in the SecurityQuestions record',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`personId`,`securityQuestionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores archived security answers.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_SecurityChallengeResponses`
--

DROP TABLE IF EXISTS `_Archive_SecurityChallengeResponses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_SecurityChallengeResponses` (
  `securityChallengeId` int unsigned NOT NULL COMMENT 'SecurityChallenge being attempted',
  `securityQuestionId` tinyint unsigned NOT NULL COMMENT 'SecurityQuestion for attempt',
  `attempt` tinyint unsigned NOT NULL DEFAULT '1',
  `response` char(32) DEFAULT NULL COMMENT 'the hashed response to the SecurityQuestion, NULL = abandoned/expired',
  `isCorrect` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'is the response correct?',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`securityChallengeId`,`securityQuestionId`,`attempt`),
  KEY `FK_SecurityQuestions_securityQuestionId` (`securityQuestionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A SecurityQuestion for each attempt of a SecurityChallenge';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_SecurityChallenges`
--

DROP TABLE IF EXISTS `_Archive_SecurityChallenges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_SecurityChallenges` (
  `securityChallengeId` int unsigned NOT NULL COMMENT 'surrogate primary key',
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetail that triggered the SecurityChallenge',
  `securityChallengeStatusId` tinyint unsigned DEFAULT NULL COMMENT 'status of the SecurityChallenge',
  `sourceUrl` varchar(255) NOT NULL COMMENT 'source URL that triggered the SecurityChallenge for redirect upon success',
  `ruleCode` varchar(255) NOT NULL COMMENT 'ruleCode that triggered the SecurityChallenge',
  `allowedAttempts` tinyint unsigned NOT NULL COMMENT 'the allowed number of attempts to pass the SecurityChallenge',
  `allowedSeconds` smallint unsigned NOT NULL COMMENT 'the time in seconds allowed to pass each attempt of the SecurityChallenge',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`securityChallengeId`),
  KEY `FK_EnrollmentDetails_enrollmentDetailId` (`enrollmentDetailId`),
  KEY `FK_SecurityChallengeStatuses_securityChallengeStatusId` (`securityChallengeStatusId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='EnrollmentDetail triggered challenges to SecurityQuestions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_SecurityQuestions`
--

DROP TABLE IF EXISTS `_Archive_SecurityQuestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_SecurityQuestions` (
  `securityQuestionId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `question` varchar(255) NOT NULL COMMENT 'Question text displayed to the person',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`securityQuestionId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 COMMENT='Stores archived security questions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_TestAnswerEssayMedia`
--

DROP TABLE IF EXISTS `_Archive_TestAnswerEssayMedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_TestAnswerEssayMedia` (
  `testAnswerEssayId` int unsigned NOT NULL COMMENT 'The TestAnswerEssay the uploaded media applies to',
  `mediaId` int unsigned NOT NULL COMMENT 'Media uploaded to the TestAnswerEssay',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`testAnswerEssayId`,`mediaId`),
  KEY `FK_Media_mediaId` (`mediaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Join table linking TestAnswerEssays to Media';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_TestAnswerEssays`
--

DROP TABLE IF EXISTS `_Archive_TestAnswerEssays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_TestAnswerEssays` (
  `testAnswerEssayId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `testQuestionId` bigint unsigned NOT NULL COMMENT 'TestQuestion the answer applies to',
  `testAnswerEssayContextId` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'context for contents of the answerText field',
  `answerText` varchar(2000) DEFAULT NULL COMMENT 'text of answer, comment on uploaded media, or instructor response',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`testAnswerEssayId`),
  UNIQUE KEY `UQ_testQuestionId_testAnswerEssayContextId` (`testQuestionId`,`testAnswerEssayContextId`),
  KEY `FK_TestAnswerEssayContexts_testAnswerEssayContextId` (`testAnswerEssayContextId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Answers and responses to essay Questions in a Test';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_TestAnswers`
--

DROP TABLE IF EXISTS `_Archive_TestAnswers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_TestAnswers` (
  `testQuestionId` bigint unsigned NOT NULL COMMENT 'TestQuestion for the recorded answer',
  `questionOptionId` int unsigned NOT NULL COMMENT 'QuestionOption of the answer chosen',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`testQuestionId`,`questionOptionId`),
  KEY `FK_QuestionOptions_questionOptionId` (`questionOptionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Recorded answer(s) to the Questions in an instance of a Test';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_TestAttributes`
--

DROP TABLE IF EXISTS `_Archive_TestAttributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_TestAttributes` (
  `testId` int unsigned NOT NULL COMMENT 'testId to which the TestAttribute applies for the key',
  `key` varchar(100) NOT NULL COMMENT 'key for the TestAttribute for the testId',
  `value` varchar(255) NOT NULL COMMENT 'value of the TestAttribute for a testId and key',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`testId`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Key/value pair table for storing things about tests';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_TestLog`
--

DROP TABLE IF EXISTS `_Archive_TestLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_TestLog` (
  `testLogId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `testId` int unsigned NOT NULL COMMENT 'The Test that was archived',
  `personId` int unsigned NOT NULL COMMENT 'The personId of the person who took the Test',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `dbUser` varchar(255) NOT NULL COMMENT 'Result of USER() when Procs.archiveTest is called',
  `action` enum('archive','restore') NOT NULL COMMENT 'The action requested: archive or restore',
  PRIMARY KEY (`testLogId`) USING BTREE,
  KEY `FK_Tests_testId` (`testId`),
  KEY `FK_PersonAccounts_personId` (`personId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COMMENT='Log of the Tests that have ever been archived.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_TestQuestions`
--

DROP TABLE IF EXISTS `_Archive_TestQuestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_TestQuestions` (
  `testQuestionId` bigint unsigned NOT NULL COMMENT 'Auto-incrementing surrogate primary key',
  `testId` int unsigned NOT NULL COMMENT 'The Test in which the Questions appear',
  `parentQuestionId` int unsigned DEFAULT NULL COMMENT 'questionId of the QuestionSet if applicable',
  `questionId` int unsigned NOT NULL COMMENT 'The Question which appears in the Test',
  `nodeId` int unsigned NOT NULL COMMENT 'nodeId for the question',
  `questionAssignmentId` int unsigned NOT NULL COMMENT 'QuestionAssignment record that assigned the Question to the Test',
  `sortOrder` smallint unsigned NOT NULL COMMENT 'Order in which the Questions appear in the Test',
  `sortSeed` int unsigned NOT NULL COMMENT 'Seed to reproduce the random sorting of the QuestionOptions',
  `points` smallint unsigned DEFAULT NULL COMMENT 'points scored on the TestQuestion',
  `pointsPossible` smallint unsigned NOT NULL COMMENT 'Points possible for the Question',
  `secondsElapsed` int unsigned NOT NULL COMMENT 'Time in seconds elapsed while the student was actively in the Question',
  `isMarkedForReview` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`testQuestionId`),
  KEY `FK_Tests_testId` (`testId`),
  KEY `FK_Questions_parentQuestionId` (`parentQuestionId`),
  KEY `FK_Questions_questionId` (`questionId`),
  KEY `FK_QuestionAssignments_questionAssignmentId` (`questionAssignmentId`),
  KEY `FK_Nodes_nodeId` (`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='The Questions in order that appear in a Test instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_Tests`
--

DROP TABLE IF EXISTS `_Archive_Tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_Tests` (
  `testId` int unsigned NOT NULL COMMENT 'Auto-incrementing surrogate primary key',
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetail to which the Test applies',
  `nodeId` int unsigned DEFAULT NULL COMMENT 'Node source for the Test',
  `nodeClassificationId` tinyint unsigned NOT NULL COMMENT 'classification of the Node source for the Test',
  `testStatusId` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'TestStatus of the Test',
  `name` varchar(255) NOT NULL COMMENT 'name of the Test',
  `lastViewedTestPosition` smallint unsigned DEFAULT NULL COMMENT 'sortOrder of the TestQuestion the Person last viewed',
  `totalQuestions` int unsigned NOT NULL COMMENT 'Number of Questions in the Test',
  `totalPoints` int unsigned DEFAULT NULL COMMENT 'total points scored on the Test',
  `totalPointsPossible` int unsigned NOT NULL COMMENT 'Number of points possible in the Test',
  `totalSecondsElapsed` int unsigned NOT NULL COMMENT 'Total time in seconds elapsed while the student was actively in the Test',
  `isInReview` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is the test in Review Mode?',
  `startedAt` timestamp NULL DEFAULT NULL COMMENT 'The time the Test was started',
  `endedAt` timestamp NULL DEFAULT NULL COMMENT 'The time the Test was ended',
  `gradedAt` timestamp NULL DEFAULT NULL COMMENT 'The time the test was graded',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`testId`),
  KEY `FK_EnrollmentDetails_enrollmentDetailId` (`enrollmentDetailId`),
  KEY `FK_Nodes_nodeId` (`nodeId`),
  KEY `FK_TestStatuses_testStatusId` (`testStatusId`),
  KEY `FK_NodeClassifications_nodeClassificationId` (`nodeClassificationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Instances of tests referencing EnrollmentContent and source';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_TestSettings`
--

DROP TABLE IF EXISTS `_Archive_TestSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_TestSettings` (
  `testId` int unsigned NOT NULL COMMENT 'Test ID',
  `settings` text NOT NULL COMMENT 'json encoded settings',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`testId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Archived test settings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Archive_TestsOffline`
--

DROP TABLE IF EXISTS `_Archive_TestsOffline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_Archive_TestsOffline` (
  `offlineTestId` char(32) NOT NULL COMMENT 'offline test id',
  `testId` int unsigned NOT NULL COMMENT 'online test id',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `archivedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was archived',
  PRIMARY KEY (`offlineTestId`),
  UNIQUE KEY `UQ_testId` (`testId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Archives Tests created offline';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_tmp_NodeStatsTimes`
--

DROP TABLE IF EXISTS `_tmp_NodeStatsTimes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_tmp_NodeStatsTimes` (
  `nodeId` int unsigned NOT NULL,
  `dimensionId` int unsigned NOT NULL,
  `durationSeconds` int unsigned DEFAULT NULL,
  PRIMARY KEY (`nodeId`,`dimensionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_tmp_ParentStats`
--

DROP TABLE IF EXISTS `_tmp_ParentStats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_tmp_ParentStats` (
  `nodeId` int unsigned NOT NULL,
  `durationSeconds` int unsigned DEFAULT NULL,
  PRIMARY KEY (`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_tmp_test_values`
--

DROP TABLE IF EXISTS `_tmp_test_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_tmp_test_values` (
  `testId` int unsigned NOT NULL,
  `key` varchar(100) NOT NULL,
  `value` varchar(255) NOT NULL,
  `new_value` varchar(255) NOT NULL,
  PRIMARY KEY (`testId`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_tmp_TestStatusIds`
--

DROP TABLE IF EXISTS `_tmp_TestStatusIds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_tmp_TestStatusIds` (
  `testId` int unsigned NOT NULL,
  `testStatusId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='PACE-11380 - Updating the testStatusId of tests to 8 (graded) for Tests that\n    are stuck in a status of 11 (Student Grade Pending), but have all questions scored';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AclResources`
--

DROP TABLE IF EXISTS `AclResources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AclResources` (
  `resourceId` smallint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Acl Resource Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Acl Resource Readable Name',
  `resource` varchar(255) NOT NULL COMMENT 'Acl Resource Id',
  `privilege` varchar(255) DEFAULT NULL COMMENT 'Acl Resource Id',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`resourceId`),
  KEY `FK_AclResources_resource_privilege` (`resource`,`privilege`)
) ENGINE=InnoDB AUTO_INCREMENT=350 DEFAULT CHARSET=utf8mb3 COMMENT='List of Resources';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AclRoles`
--

DROP TABLE IF EXISTS `AclRoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AclRoles` (
  `aclRoleId` smallint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `role` varchar(50) NOT NULL COMMENT 'unique name given to the AclRole',
  `description` varchar(255) DEFAULT NULL COMMENT 'description of the AclRole',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`aclRoleId`),
  UNIQUE KEY `UQ_role` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8mb3 COMMENT='ACL Roles that request access to resources';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AclRolesGraph`
--

DROP TABLE IF EXISTS `AclRolesGraph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AclRolesGraph` (
  `parentAclRoleId` smallint unsigned NOT NULL COMMENT 'AclRole from which AclRules are inherited',
  `childAclRoleId` smallint unsigned NOT NULL COMMENT 'AclRole to which AclRules are inherited',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`parentAclRoleId`,`childAclRoleId`),
  KEY `FK_AclRoles_childAclRoleId` (`childAclRoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Graph the inheritance model of AclRoles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AclRules`
--

DROP TABLE IF EXISTS `AclRules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AclRules` (
  `aclRuleId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `aclRoleId` smallint unsigned DEFAULT NULL COMMENT 'AclRole allowed or denied access to a resource and/or privilege',
  `resourceId` smallint unsigned NOT NULL COMMENT 'Acl Resource Id',
  `isAllowed` tinyint(1) NOT NULL COMMENT 'allowed or denied',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`aclRuleId`),
  KEY `IX_aclRoleId_resourceId` (`aclRoleId`,`resourceId`)
) ENGINE=InnoDB AUTO_INCREMENT=432 DEFAULT CHARSET=utf8mb3 COMMENT='Define how resources can be accessed by AclRoles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Activities`
--

DROP TABLE IF EXISTS `Activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Activities` (
  `activityId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Activity ID',
  `activityGroupId` int unsigned NOT NULL COMMENT 'Activity Group ID',
  `activityTypeId` tinyint unsigned NOT NULL COMMENT 'Activity Type ID',
  `activityLabelId` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'Activity Label ID',
  `sortOrder` mediumint unsigned NOT NULL COMMENT 'Sort Order of Activity within Activity Group',
  `name` varchar(255) NOT NULL COMMENT 'Activity Name',
  `content` varchar(500) DEFAULT NULL COMMENT 'Activity Content',
  `moduleLinkId` int unsigned DEFAULT NULL COMMENT 'Module Link ID',
  `durationMinutes` smallint unsigned DEFAULT NULL COMMENT 'Activity estimated duration in minutes',
  `isMilestone` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Whether the activity is a milestone',
  `isPerformMilestone` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Whether the activity is a perform milestone',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`activityId`),
  UNIQUE KEY `UQ_activityGroupId_sortOrder` (`activityGroupId`,`sortOrder`),
  KEY `FK_activityTypeId` (`activityTypeId`),
  KEY `FK_moduleLinkId` (`moduleLinkId`),
  KEY `FK_activityLabelId` (`activityLabelId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB AUTO_INCREMENT=84056 DEFAULT CHARSET=utf8mb3 COMMENT='Activities assigned to Activity Groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ActivityGroupNodeRoots`
--

DROP TABLE IF EXISTS `ActivityGroupNodeRoots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ActivityGroupNodeRoots` (
  `activityGroupId` int unsigned NOT NULL COMMENT 'Activity Group Id',
  `nodeRootId` int unsigned NOT NULL COMMENT 'Node Root Id',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`activityGroupId`,`nodeRootId`),
  KEY `FK_NodeRoots_nodeRootId` (`nodeRootId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Activity Group  Node Roots';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ActivityGroups`
--

DROP TABLE IF EXISTS `ActivityGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ActivityGroups` (
  `activityGroupId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Activity Group ID',
  `name` varchar(100) NOT NULL COMMENT 'Activity Group Name',
  `isArchived` tinyint unsigned NOT NULL COMMENT 'Whether the Activity Group is Archived',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`activityGroupId`),
  UNIQUE KEY `UQ_name` (`name`),
  KEY `IX_isArchived` (`isArchived`)
) ENGINE=InnoDB AUTO_INCREMENT=449 DEFAULT CHARSET=utf8mb3 COMMENT='Activity Groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ActivityGroupTags`
--

DROP TABLE IF EXISTS `ActivityGroupTags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ActivityGroupTags` (
  `activityGroupTagId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Activity Group Tag ID',
  `activityGroupId` int unsigned NOT NULL COMMENT 'Activity Group ID',
  `tag` varchar(100) NOT NULL COMMENT 'Activity Group Tag',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`activityGroupTagId`),
  UNIQUE KEY `UQ_activityGroupId_tag` (`activityGroupId`,`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=3253 DEFAULT CHARSET=utf8mb3 COMMENT='Tags used on activities within the group';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ActivityGroupTaskGroups`
--

DROP TABLE IF EXISTS `ActivityGroupTaskGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ActivityGroupTaskGroups` (
  `activityGroupTaskGroupId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Activity Group TaskGroup ID',
  `activityGroupId` int unsigned NOT NULL COMMENT 'Activity Group ID',
  `taskGroupName` varchar(255) NOT NULL COMMENT 'Name of the Task Group',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`activityGroupTaskGroupId`),
  UNIQUE KEY `UQ_activityGroupId_taskGroupName` (`activityGroupId`,`taskGroupName`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COMMENT='Task Groups to group activities within the activity group';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ActivityGroupTopics`
--

DROP TABLE IF EXISTS `ActivityGroupTopics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ActivityGroupTopics` (
  `activityGroupTopicId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Activity Group Topic ID',
  `activityGroupId` int unsigned NOT NULL COMMENT 'Activity Group ID',
  `activityTopicWeightId` tinyint unsigned DEFAULT NULL COMMENT 'Activity Group Topic Weight',
  `topic` varchar(255) NOT NULL COMMENT 'Activity Group Topic',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`activityGroupTopicId`),
  UNIQUE KEY `UQ_activityGroupId_topic` (`activityGroupId`,`topic`),
  KEY `FK_activityTopicWeightId` (`activityTopicWeightId`)
) ENGINE=InnoDB AUTO_INCREMENT=2094 DEFAULT CHARSET=utf8mb3 COMMENT='Topics used on activities within the group';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ActivityLabels`
--

DROP TABLE IF EXISTS `ActivityLabels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ActivityLabels` (
  `activityLabelId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(255) NOT NULL COMMENT 'Activity Label Name',
  `description` varchar(255) NOT NULL COMMENT 'Activity Label description',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`activityLabelId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb3 COMMENT='Labels of Activities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ActivityPerformanceTopics`
--

DROP TABLE IF EXISTS `ActivityPerformanceTopics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ActivityPerformanceTopics` (
  `activityGroupId` int unsigned NOT NULL COMMENT 'Activity Group Id',
  `activityId` int unsigned NOT NULL COMMENT 'Activity Id',
  `nodeId` int unsigned NOT NULL COMMENT 'Root/Parent Node Id',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`activityGroupId`,`activityId`,`nodeId`),
  KEY `FK_Nodes_nodeId` (`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Activity Performance Topics';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ActivityTags`
--

DROP TABLE IF EXISTS `ActivityTags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ActivityTags` (
  `activityId` int unsigned NOT NULL COMMENT 'Activity ID',
  `activityGroupTagId` int unsigned NOT NULL COMMENT 'Activity Group Tag ID',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`activityId`,`activityGroupTagId`),
  KEY `FK_activityGroupTagId` (`activityGroupTagId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Activity Tags';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ActivityTaskGroup`
--

DROP TABLE IF EXISTS `ActivityTaskGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ActivityTaskGroup` (
  `activityId` int unsigned NOT NULL COMMENT 'Activity ID',
  `activityGroupTaskGroupId` int unsigned NOT NULL COMMENT 'Task Group ID',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`activityId`),
  KEY `FK_activityGroupTaskGroupId` (`activityGroupTaskGroupId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Tags an activity to a task group';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ActivityTopics`
--

DROP TABLE IF EXISTS `ActivityTopics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ActivityTopics` (
  `activityId` int unsigned NOT NULL COMMENT 'Activity ID',
  `activityGroupTopicId` int unsigned NOT NULL COMMENT 'Activity Group Topic ID',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`activityId`,`activityGroupTopicId`),
  KEY `FK_activityGroupTopicId` (`activityGroupTopicId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Activity Topics';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ActivityTopicWeights`
--

DROP TABLE IF EXISTS `ActivityTopicWeights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ActivityTopicWeights` (
  `activityTopicWeightId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(255) NOT NULL COMMENT 'name for the ActivityTopicWeight',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`activityTopicWeightId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='Activity topic weights';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ActivityTypes`
--

DROP TABLE IF EXISTS `ActivityTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ActivityTypes` (
  `activityTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(255) NOT NULL COMMENT 'Activity Type Name',
  `description` varchar(255) NOT NULL COMMENT 'Activity Type description',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`activityTypeId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='Types of Activities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AdaptivePerformanceLabels`
--

DROP TABLE IF EXISTS `AdaptivePerformanceLabels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AdaptivePerformanceLabels` (
  `adaptivePerformanceLabelId` tinyint unsigned NOT NULL COMMENT 'ID for the Performance Label',
  `label` varchar(50) NOT NULL COMMENT 'Performance Label',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`adaptivePerformanceLabelId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Performance Labels for Adaptive QBank';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BookmarkNotes`
--

DROP TABLE IF EXISTS `BookmarkNotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BookmarkNotes` (
  `enrollmentDetailId` int NOT NULL COMMENT 'EnrollmentDetail that the bookmarkNotes apply to',
  `nodeId` int unsigned NOT NULL COMMENT 'Node',
  `noteText` text COMMENT 'The text content of the bookmarkNotes',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'PersonId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'PersonId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`,`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores bookmarkNotes text message';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CalendarDaysOffGroups`
--

DROP TABLE IF EXISTS `CalendarDaysOffGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CalendarDaysOffGroups` (
  `calendarDaysOffGroupId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'calendarDaysOffGroupId',
  `productGroup` varchar(50) NOT NULL COMMENT 'product group',
  `productLevel` varchar(20) NOT NULL COMMENT 'product level',
  `name` varchar(255) NOT NULL COMMENT 'calendar days off group name',
  `isArchived` tinyint(1) NOT NULL COMMENT 'is archived',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`calendarDaysOffGroupId`),
  UNIQUE KEY `UQ_name` (`name`),
  KEY `IX_isArchived` (`isArchived`)
) ENGINE=InnoDB AUTO_INCREMENT=1724 DEFAULT CHARSET=utf8mb3 COMMENT='Lookup table for Calendar Days Off Groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CalendarFixedDays`
--

DROP TABLE IF EXISTS `CalendarFixedDays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CalendarFixedDays` (
  `calendarFixedDaysGroupId` int unsigned NOT NULL COMMENT 'ID from CalendarFixedDaysGroups table',
  `nodeId` int unsigned NOT NULL COMMENT 'Task nodeId from Nodes table',
  `date` date NOT NULL COMMENT 'The fixed date for the task',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`calendarFixedDaysGroupId`,`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Table that stores fixed dates for tasks';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CalendarFixedDaysGroups`
--

DROP TABLE IF EXISTS `CalendarFixedDaysGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CalendarFixedDaysGroups` (
  `calendarFixedDaysGroupId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-increment ID for the group',
  `name` varchar(100) NOT NULL COMMENT 'The name of the group',
  `calendarFixedDaysGroupTypeId` tinyint unsigned NOT NULL DEFAULT '1',
  `activityGroupId` int unsigned NOT NULL DEFAULT '0',
  `nodeRootId` int unsigned NOT NULL COMMENT 'The node root of the calendar',
  `productGroup` varchar(50) NOT NULL COMMENT 'Product group',
  `productLevel` varchar(20) NOT NULL COMMENT 'Product level',
  `isArchived` tinyint(1) NOT NULL COMMENT 'Whether or not this record is archived',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`calendarFixedDaysGroupId`),
  UNIQUE KEY `UQ_name` (`name`),
  KEY `IX_isArchived` (`isArchived`)
) ENGINE=InnoDB AUTO_INCREMENT=1030 DEFAULT CHARSET=utf8mb3 COMMENT='Lookup table for calendar fixed days group names';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CalendarFixedDaysGroupTypes`
--

DROP TABLE IF EXISTS `CalendarFixedDaysGroupTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CalendarFixedDaysGroupTypes` (
  `calendarFixedDaysGroupTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing primary key',
  `name` varchar(255) NOT NULL COMMENT 'The name of the Calendar Type',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`calendarFixedDaysGroupTypeId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='Table that stores calendar type for fixed days group';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CalendarGroupDaysOff`
--

DROP TABLE IF EXISTS `CalendarGroupDaysOff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CalendarGroupDaysOff` (
  `calendarDayOffId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'calendarDayOffId',
  `calendarDaysOffGroupId` int unsigned NOT NULL COMMENT 'calendarDaysOffGroupId',
  `offDate` date NOT NULL COMMENT 'The Off Date',
  `calendarOffDateRepeatTypeId` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'The Repeat Type ID',
  `title` varchar(255) NOT NULL COMMENT 'Day Off Title',
  `description` varchar(2000) NOT NULL COMMENT 'Description',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`calendarDayOffId`),
  UNIQUE KEY `UQ_calendarDaysOffGroupId_offDate_calendarOffDateRepeatTypeId` (`calendarDaysOffGroupId`,`offDate`,`calendarOffDateRepeatTypeId`),
  KEY `FK_calendarOffDateRepeatTypeId` (`calendarOffDateRepeatTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=8811 DEFAULT CHARSET=utf8mb3 COMMENT='Lookup table for Calendar Group Days Off';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CalendarOffDateRepeatTypes`
--

DROP TABLE IF EXISTS `CalendarOffDateRepeatTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CalendarOffDateRepeatTypes` (
  `calendarOffDateRepeatTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(20) NOT NULL COMMENT 'name that describes the repeating off date interval',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`calendarOffDateRepeatTypeId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COMMENT='Repeat types for CalendarOffDates; weekly, monthly, etc.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CalendarOffDates`
--

DROP TABLE IF EXISTS `CalendarOffDates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CalendarOffDates` (
  `calendarId` int unsigned NOT NULL COMMENT 'Calendar that requires specific off dates from scheduled tasks',
  `calendarOffDateRepeatTypeId` tinyint unsigned NOT NULL DEFAULT '1',
  `offDate` date NOT NULL COMMENT 'specific off date requested from scheduled tasks',
  `title` varchar(45) NOT NULL COMMENT 'title of the off date from scheduled tasks',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`calendarId`,`calendarOffDateRepeatTypeId`,`offDate`),
  KEY `FK_CalendarOffDateRepeatTypes_calendarOffDateRepeatTypeId` (`calendarOffDateRepeatTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Specific off dates requested from having tasks by Calendar';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Calendars`
--

DROP TABLE IF EXISTS `Calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Calendars` (
  `calendarId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `personId` int unsigned NOT NULL COMMENT 'PersonAccount that owns the Calendar',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`calendarId`),
  KEY `FK_PersonAccounts_personId` (`personId`)
) ENGINE=InnoDB AUTO_INCREMENT=1729471 DEFAULT CHARSET=utf8mb3 COMMENT='Container to organize a collection of PersonEvents';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ContentMedia`
--

DROP TABLE IF EXISTS `ContentMedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ContentMedia` (
  `contentId` int unsigned NOT NULL COMMENT 'The Content to which the Media applies',
  `mediaId` int unsigned NOT NULL COMMENT 'The Media to which the Content applies',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`contentId`,`mediaId`),
  KEY `FK_Media_mediaId` (`mediaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Join table linking Contents to Media';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ContentModuleLinks`
--

DROP TABLE IF EXISTS `ContentModuleLinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ContentModuleLinks` (
  `contentId` int unsigned NOT NULL COMMENT 'The Content to which the ModuleLink applies',
  `moduleLinkId` int unsigned NOT NULL COMMENT 'The moduleLinkId assigned to content',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`contentId`,`moduleLinkId`),
  KEY `moduleLinkId` (`moduleLinkId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Join table linking Contents to Module Link IDs';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Contents`
--

DROP TABLE IF EXISTS `Contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Contents` (
  `contentId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `contentTypeId` tinyint unsigned NOT NULL COMMENT 'contentTypeId for this Content',
  `contentText` text NOT NULL COMMENT 'Text and markup of the Content',
  `hash` char(32) NOT NULL COMMENT 'MD5 of the Content',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`contentId`),
  UNIQUE KEY `UQ_hash` (`hash`),
  KEY `FK_ContentTypes_contentTypeId` (`contentTypeId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB AUTO_INCREMENT=3140164 DEFAULT CHARSET=utf8mb3 COMMENT='The content for the Courses, Tests, etc';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ContentTypes`
--

DROP TABLE IF EXISTS `ContentTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ContentTypes` (
  `contentTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(255) NOT NULL COMMENT 'name for the type of Content',
  `description` varchar(255) NOT NULL COMMENT 'description for the type of Content',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`contentTypeId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COMMENT='Types of Content available';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ContentUcms`
--

DROP TABLE IF EXISTS `ContentUcms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ContentUcms` (
  `contentId` int unsigned NOT NULL COMMENT 'The Content to which the UCMS ID applies',
  `ucmsId` bigint unsigned NOT NULL COMMENT 'The UCMS ID assigned to the Content',
  `ucmsTypeId` tinyint unsigned NOT NULL COMMENT 'ucms type Id',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`contentId`,`ucmsId`),
  KEY `IX_ucmsTypeId` (`ucmsTypeId`),
  KEY `idx_contentUcms_ucmsId_contentId` (`ucmsId`,`contentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Join table linking Contents to UCMS IDs';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DashboardViews`
--

DROP TABLE IF EXISTS `DashboardViews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DashboardViews` (
  `dashboardViewId` tinyint unsigned NOT NULL COMMENT 'Dashboard view ID',
  `name` varchar(255) NOT NULL COMMENT 'Dashboard view name',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`dashboardViewId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Dashboard views';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DATABASECHANGELOG`
--

DROP TABLE IF EXISTS `DATABASECHANGELOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DATABASECHANGELOG` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(63) NOT NULL,
  `FILENAME` varchar(200) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`,`AUTHOR`,`FILENAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DATABASECHANGELOGLOCK`
--

DROP TABLE IF EXISTS `DATABASECHANGELOGLOCK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DATABASECHANGELOGLOCK` (
  `ID` int NOT NULL,
  `LOCKED` tinyint(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DimensionImportHistory`
--

DROP TABLE IF EXISTS `DimensionImportHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DimensionImportHistory` (
  `dimensionId` int unsigned NOT NULL COMMENT 'Dimension ID',
  `systemId` tinyint unsigned NOT NULL COMMENT 'System ID',
  `importerId` tinyint unsigned NOT NULL COMMENT 'Importer ID',
  `foreignId` varchar(255) NOT NULL COMMENT 'Foreign ID',
  `isSubset` tinyint unsigned NOT NULL COMMENT 'Whether the import was a subset of nodes',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'Person ID that created the record',
  PRIMARY KEY (`dimensionId`,`createdAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='History of all imports on the dimension';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DimensionReferences`
--

DROP TABLE IF EXISTS `DimensionReferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DimensionReferences` (
  `dimensionId` int unsigned NOT NULL COMMENT 'Dimension ID',
  `systemId` tinyint unsigned NOT NULL COMMENT 'Foreign system from which the Dimension originated',
  `importerId` tinyint unsigned NOT NULL COMMENT 'Importer used to import the Dimension',
  `foreignId` varchar(255) NOT NULL COMMENT 'ID value from the foreign system',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`dimensionId`),
  KEY `IX_systemId_foreignId` (`systemId`,`foreignId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Lookup table for foreign ID and system by Dimension';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Dimensions`
--

DROP TABLE IF EXISTS `Dimensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Dimensions` (
  `dimensionId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `dimensionTypeId` tinyint unsigned NOT NULL COMMENT 'Type for the Dimension',
  `nodeRootId` int unsigned NOT NULL COMMENT 'NodeRoot to which the Dimension belongs',
  `name` varchar(50) NOT NULL COMMENT 'name for the Dimension',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`dimensionId`),
  UNIQUE KEY `UQ_nodeRootId_name` (`nodeRootId`,`name`),
  KEY `FK_DimensionTypes_dimensionTypeId` (`dimensionTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=58107 DEFAULT CHARSET=utf8mb3 COMMENT='Describes how Nodes relate to Content';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DimensionTypes`
--

DROP TABLE IF EXISTS `DimensionTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DimensionTypes` (
  `dimensionTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(255) NOT NULL COMMENT 'The name of the DimensionType',
  `description` varchar(255) NOT NULL COMMENT 'The description of the DimensionType',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`dimensionTypeId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3 COMMENT='Types of Dimensions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DiscussionMedia`
--

DROP TABLE IF EXISTS `DiscussionMedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DiscussionMedia` (
  `discussionId` int unsigned NOT NULL COMMENT 'Discussion related to the message',
  `sortOrder` smallint unsigned NOT NULL COMMENT 'Order of messages in discussion',
  `mediaId` int unsigned NOT NULL COMMENT 'The Media to which the Discussion applies',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`discussionId`,`sortOrder`,`mediaId`),
  KEY `mediaId` (`mediaId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Relationship of discussions to media assets';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DiscussionMessages`
--

DROP TABLE IF EXISTS `DiscussionMessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DiscussionMessages` (
  `discussionId` int unsigned NOT NULL COMMENT 'Discussion related to the message',
  `sortOrder` smallint unsigned NOT NULL COMMENT 'Order of messages in discussion',
  `personId` int unsigned NOT NULL COMMENT 'Person that sent the message',
  `messageText` text NOT NULL COMMENT 'Text of the message',
  `isRead` tinyint unsigned NOT NULL COMMENT 'Whether the message was read by the person that started the discussion',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`discussionId`,`sortOrder`),
  KEY `FK_PersonAccounts_personId` (`personId`),
  KEY `updatedAt` (`updatedAt`),
  KEY `idx_discussionmessages_discussion_sortorder2` (`discussionId`,`sortOrder`,`createdAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='List of Discussion Messages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DiscussionNodes`
--

DROP TABLE IF EXISTS `DiscussionNodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DiscussionNodes` (
  `discussionId` int unsigned NOT NULL COMMENT 'Discussion',
  `nodeId` int unsigned NOT NULL COMMENT 'Node',
  `dimensionId` int unsigned NOT NULL COMMENT 'Dimension for the node',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`discussionId`),
  KEY `IX_nodeId_dimensionId` (`nodeId`,`dimensionId`),
  KEY `FK_Dimensions_dimensionId` (`dimensionId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Relationships between discussions and nodes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DiscussionOfferings`
--

DROP TABLE IF EXISTS `DiscussionOfferings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DiscussionOfferings` (
  `discussionId` int unsigned NOT NULL COMMENT 'Discussion',
  `offeringId` int unsigned NOT NULL COMMENT 'Offering',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`discussionId`),
  KEY `FK_Offerings_offeringId` (`offeringId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Relationships between discussions and offerings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DiscussionQuestions`
--

DROP TABLE IF EXISTS `DiscussionQuestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DiscussionQuestions` (
  `discussionId` int unsigned NOT NULL COMMENT 'Discussion',
  `questionId` int unsigned NOT NULL COMMENT 'Question',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`discussionId`),
  KEY `FK_Questions_questionId` (`questionId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Relationships between discussions and questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Discussions`
--

DROP TABLE IF EXISTS `Discussions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Discussions` (
  `discussionId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `personId` int unsigned NOT NULL COMMENT 'Person that started the discussion',
  `discussionTypeId` tinyint unsigned NOT NULL COMMENT 'Type of discussion',
  `subject` varchar(255) NOT NULL COMMENT 'Subject of the discussion',
  `isArchived` tinyint(1) NOT NULL COMMENT 'If discussion is archived',
  `emailed` tinyint(1) DEFAULT NULL COMMENT 'indicates if discussion was emailed',
  `offeringGroup` varchar(255) NOT NULL COMMENT 'Offering Group ID',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`discussionId`),
  KEY `FK_PersonAccounts_personId` (`personId`),
  KEY `FK_DiscussionTypes_discussionTypeId` (`discussionTypeId`),
  KEY `IX_isArchived` (`isArchived`),
  KEY `updatedAt` (`updatedAt`),
  KEY `idx_discussions_archived_type_emailed` (`isArchived`,`discussionTypeId`,`emailed`)
) ENGINE=InnoDB AUTO_INCREMENT=411593 DEFAULT CHARSET=utf8mb3 COMMENT='List of Discussions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DiscussionTypes`
--

DROP TABLE IF EXISTS `DiscussionTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DiscussionTypes` (
  `discussionTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(255) NOT NULL COMMENT 'The name of the DiscussionType',
  `description` varchar(255) NOT NULL COMMENT 'The description of the DiscussionType',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`discussionTypeId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COMMENT='Types of Discussions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DomTest`
--

DROP TABLE IF EXISTS `DomTest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DomTest` (
  `domtestId` int NOT NULL AUTO_INCREMENT,
  `n` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`domtestId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailActivityGroupTopics`
--

DROP TABLE IF EXISTS `EnrollmentDetailActivityGroupTopics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailActivityGroupTopics` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'Enrollment Detail to which the activity was assigned',
  `activityGroupTopicId` int unsigned NOT NULL COMMENT 'Activity group topic',
  `sortOrder` tinyint unsigned NOT NULL COMMENT 'Sort order of topic',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`,`activityGroupTopicId`),
  KEY `FK_activityGroupTopicId` (`activityGroupTopicId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Maintains the order of topics within an activity feed enrollment detail';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailActivityStatus`
--

DROP TABLE IF EXISTS `EnrollmentDetailActivityStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailActivityStatus` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'Enrollment Detail to which the activity was assigned',
  `activityId` int unsigned NOT NULL COMMENT 'Activity that was completed',
  `isComplete` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether the activity is completed',
  `markedForReview` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether the activity is marked for review',
  `completedAt` timestamp NULL DEFAULT NULL COMMENT 'time the activity was completed',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`,`activityId`),
  KEY `FK_activityId` (`activityId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Activities completed in an Enrollment Detail';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailCalendars`
--

DROP TABLE IF EXISTS `EnrollmentDetailCalendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailCalendars` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetail that owns the assigned Calendar',
  `calendarId` int unsigned NOT NULL COMMENT 'Calendar assigned to the EnrollmentDetail',
  `startDate` date NOT NULL COMMENT 'date the Calendar starts',
  `endDate` date NOT NULL COMMENT 'date the Calendar ends',
  `hash` char(32) DEFAULT NULL COMMENT 'Hash of calendar setting during activity schedule',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`),
  UNIQUE KEY `UQ_calendarId` (`calendarId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Ties a single EnrollmentDetail to a single Calendar';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailDownloads`
--

DROP TABLE IF EXISTS `EnrollmentDetailDownloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailDownloads` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'Enrollment detail that was downloaded',
  `userAgentId` int NOT NULL COMMENT 'User agent Id',
  `ip` int unsigned NOT NULL DEFAULT '0' COMMENT 'IP address',
  `downloadCount` tinyint unsigned DEFAULT '0' COMMENT 'Count of successful download attempts',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`,`userAgentId`,`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores the count of downloads of an offline offeringDetail';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailHighlights`
--

DROP TABLE IF EXISTS `EnrollmentDetailHighlights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailHighlights` (
  `enrollmentDetailId` int NOT NULL COMMENT 'EnrollmentDetail that the highlights apply to',
  `testId` int unsigned NOT NULL COMMENT 'testId of the highlights, optional field',
  `key` varchar(100) NOT NULL COMMENT 'Key name for data',
  `value` varchar(255) NOT NULL COMMENT 'Page param value',
  `range` varchar(500) NOT NULL COMMENT 'highlighted text range',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'PersonId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'PersonId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`,`key`,`value`,`testId`),
  KEY `testId` (`testId`),
  KEY `key` (`key`),
  KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores EnrollmentDetail Highlights';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailLinks`
--

DROP TABLE IF EXISTS `EnrollmentDetailLinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailLinks` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetail that owns the 3rd Party Link ID',
  `linkId` bigint unsigned NOT NULL COMMENT 'The associated 3rd Party Link ID',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`),
  KEY `IX_linkId` (`linkId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Ties a single EnrollmentDetail to a 3rd Party Link';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailNodeAdaptiveRatings`
--

DROP TABLE IF EXISTS `EnrollmentDetailNodeAdaptiveRatings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailNodeAdaptiveRatings` (
  `enrollmentDetailNodeAdaptiveRatingId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-Incrementing Primary Key',
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'Enrollment Detail ID',
  `nodeId` int unsigned NOT NULL COMMENT 'Node ID',
  `rating` int unsigned NOT NULL COMMENT 'Adaptive Rating',
  `adaptivePerformanceLabelId` tinyint unsigned DEFAULT NULL COMMENT 'The performance label for the rating',
  `questionId` int unsigned DEFAULT NULL COMMENT 'The question answered to achieve the rating',
  `parentQuestionId` int unsigned DEFAULT NULL COMMENT 'The parent question of the answered question',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailNodeAdaptiveRatingId`),
  KEY `IX_enrollmentDetailId_nodeId` (`enrollmentDetailId`,`nodeId`),
  KEY `nodeId` (`nodeId`),
  KEY `FK_questionId` (`questionId`),
  KEY `FK_parentQuestionId` (`parentQuestionId`),
  KEY `FK_adaptivePerformanceLabelId` (`adaptivePerformanceLabelId`)
) ENGINE=InnoDB AUTO_INCREMENT=6076575 DEFAULT CHARSET=utf8mb3 COMMENT='History of adaptive ratings for enrollment detail';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailNodePoints`
--

DROP TABLE IF EXISTS `EnrollmentDetailNodePoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailNodePoints` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetail that has points assigned to a Node',
  `nodeId` int unsigned NOT NULL COMMENT 'Node with points assigned',
  `totalPoints` int unsigned NOT NULL COMMENT 'total points scored on the Node by the EnrollmentDetail',
  `totalPointsPossible` int unsigned NOT NULL COMMENT 'total points possible for the Node by the EnrollmentDetail',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`,`nodeId`),
  KEY `FK_Nodes_nodeId` (`nodeId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Points scored and possible for Nodes by EnrollmentDetail';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailNodeQuestionBookmarkNotes`
--

DROP TABLE IF EXISTS `EnrollmentDetailNodeQuestionBookmarkNotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailNodeQuestionBookmarkNotes` (
  `enrollmentDetailId` int NOT NULL COMMENT 'EnrollmentDetail that the bookmarkNotes apply to',
  `nodeId` int unsigned NOT NULL COMMENT 'node source for the questions',
  `questionId` int unsigned NOT NULL COMMENT 'QuestionId',
  `noteText` text COMMENT 'The text content of the Question BookmarkNotes',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'PersonId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'PersonId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`,`nodeId`,`questionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores Question BookmarkNotes text message';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailNodeQuestionStatistics`
--

DROP TABLE IF EXISTS `EnrollmentDetailNodeQuestionStatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailNodeQuestionStatistics` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'the enrollmentDetailId for these node stats',
  `nodeId` int unsigned NOT NULL COMMENT 'node source for the questions',
  `questionId` int unsigned NOT NULL COMMENT 'question that is assigned to node',
  `points` int unsigned NOT NULL COMMENT 'points scored for the question',
  `pointsPossible` int unsigned NOT NULL COMMENT 'point possible for the question',
  `secondsElapsed` smallint unsigned NOT NULL COMMENT 'seconds elapsed during most recent attempt',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`,`nodeId`,`questionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='stores stats for questions answered within a node';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailNodeStatistics`
--

DROP TABLE IF EXISTS `EnrollmentDetailNodeStatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailNodeStatistics` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'the enrollmentDetailId for these node stats',
  `nodeId` int unsigned NOT NULL COMMENT 'node source for the questions',
  `accruedSeconds` int unsigned NOT NULL DEFAULT '0' COMMENT 'aggregate time for node and its children',
  `questionAccruedSeconds` int unsigned NOT NULL DEFAULT '0' COMMENT 'aggregate time for node questions and child node questions',
  `childrenComplete` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'count of completed content for self plus children',
  `answeredCount` int unsigned NOT NULL DEFAULT '0' COMMENT 'number of questions answered in a node',
  `incorrectCount` int unsigned NOT NULL DEFAULT '0' COMMENT 'number of questions answered incorrectly in a node',
  `points` int unsigned NOT NULL DEFAULT '0' COMMENT 'points achieved for questions answered in a node',
  `pointsPossible` int unsigned NOT NULL DEFAULT '0' COMMENT 'points possible for questions answered in a node',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`,`nodeId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='stores sum of stats for questions answered within a node';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailNodeStatus`
--

DROP TABLE IF EXISTS `EnrollmentDetailNodeStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailNodeStatus` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetail that viewed a Node',
  `nodeId` int unsigned NOT NULL COMMENT 'Node viewed',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`,`nodeId`),
  KEY `FK_Nodes_nodeId` (`nodeId`),
  KEY `IX_updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='The viewed Nodes by EnrollmentDetail';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailNodeTimes`
--

DROP TABLE IF EXISTS `EnrollmentDetailNodeTimes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailNodeTimes` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetail that accumulated time in a Node',
  `nodeId` int unsigned NOT NULL COMMENT 'Node in which the time was accumulated',
  `accumulatedAt` datetime NOT NULL COMMENT 'The date and hour the time was accumulated for an EnrollmentDetail in a Node',
  `seconds` mediumint unsigned NOT NULL COMMENT 'Time in seconds accumulated by an EnrollmentDetail in a Node on a given date',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`,`nodeId`,`accumulatedAt`),
  KEY `FK_Nodes_nodeId` (`nodeId`),
  KEY `IX_enrollmentDetailId_accumulatedAt` (`enrollmentDetailId`,`accumulatedAt`),
  KEY `IX_updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='The time spent per day by EnrollmentDetail and Node';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetails`
--

DROP TABLE IF EXISTS `EnrollmentDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetails` (
  `enrollmentDetailId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `enrollmentId` int unsigned NOT NULL COMMENT 'The Enrollment for these OfferingDetailNodeRoot instances',
  `offeringDetailId` int unsigned NOT NULL COMMENT 'The OfferingDetail in this Enrollment',
  `lastNodeViewed` int unsigned DEFAULT NULL COMMENT 'last viewed Node',
  `lastNodeViewedAt` timestamp NULL DEFAULT NULL COMMENT 'timestamp for the last viewed Node',
  `lastViewedAt` timestamp NULL DEFAULT NULL COMMENT 'The time that this detail was last viewed',
  `score` tinyint unsigned DEFAULT NULL COMMENT 'The score for this completed OfferingDetailNodeRoot instance',
  `isLocked` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether or not this EnrollmentDetail is locked from launching',
  `startedAt` timestamp NULL DEFAULT NULL COMMENT 'The time in which the OfferingDetailNodeRoot instance of this Enrollment began',
  `completedAt` timestamp NULL DEFAULT NULL COMMENT 'The time in which the OfferingDetailNodeRoot instance of this Enrollment was completed',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`),
  KEY `FK_Enrollments_enrollmentId` (`enrollmentId`),
  KEY `FK_OfferingDetails_offeringDetailId` (`offeringDetailId`),
  KEY `FK_Nodes_lastNodeViewed` (`lastNodeViewed`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB AUTO_INCREMENT=104896094 DEFAULT CHARSET=utf8mb3 COMMENT='The OfferingDetailNodeRoot an Enrollment contains';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetails-trav`
--

DROP TABLE IF EXISTS `EnrollmentDetails-trav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetails-trav` (
  `enrollmentId` int unsigned NOT NULL COMMENT 'The Enrollment for these OfferingDetailNodeRoot instances',
  `personId` int unsigned DEFAULT NULL,
  `assignmentId` int unsigned DEFAULT NULL,
  `offeringid` int unsigned DEFAULT '156360',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` tinyint unsigned DEFAULT '1',
  `updatedBy` tinyint unsigned DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailSettings`
--

DROP TABLE IF EXISTS `EnrollmentDetailSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailSettings` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'enrollment detail',
  `settings` text NOT NULL COMMENT 'json encoded settings',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Enrollment detail settings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailTokens`
--

DROP TABLE IF EXISTS `EnrollmentDetailTokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailTokens` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetailId detail of the token',
  `token` char(32) NOT NULL COMMENT 'token for providing enrollment Identity',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  PRIMARY KEY (`enrollmentDetailId`),
  UNIQUE KEY `UQ_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores tokens for autorizing to sync offline tests';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailUcmsStatistics`
--

DROP TABLE IF EXISTS `EnrollmentDetailUcmsStatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailUcmsStatistics` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'the enrollmentDetailId',
  `nodeId` int unsigned NOT NULL COMMENT 'node Id',
  `ucmsId` bigint unsigned NOT NULL COMMENT 'UCMS Id',
  `accruedSeconds` int unsigned DEFAULT NULL COMMENT 'accrued time in seconds in the live seminar',
  `lastViewedAt` timestamp NULL DEFAULT NULL COMMENT 'the time that this live seminar was last viewed',
  `ucmsPollId` int unsigned DEFAULT NULL COMMENT 'poll id for this live seminar',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`,`nodeId`,`ucmsId`),
  KEY `ucmsPollId` (`ucmsPollId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='stores stats for live seminars within a node';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailVideoChannels`
--

DROP TABLE IF EXISTS `EnrollmentDetailVideoChannels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailVideoChannels` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'Enrollment Detail ID',
  `videoChannelId` int unsigned NOT NULL COMMENT 'Video Channel ID',
  `ucmsId` bigint unsigned NOT NULL COMMENT 'UCMS ID to add to channel',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`ucmsId`,`enrollmentDetailId`,`videoChannelId`),
  KEY `FK_enrollmentDetailId` (`enrollmentDetailId`),
  KEY `FK_videoChannelId` (`videoChannelId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Enrollment Detail Videos added to Video Channel';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentDetailVouchers`
--

DROP TABLE IF EXISTS `EnrollmentDetailVouchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentDetailVouchers` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetailId detail of the Voucher',
  `voucher` varchar(64) NOT NULL COMMENT 'voucher code for downloading a product like Gmetrix',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`),
  UNIQUE KEY `UQ_voucher` (`voucher`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores voucher codes for downloading a product like Gmetrix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentPortalCodes`
--

DROP TABLE IF EXISTS `EnrollmentPortalCodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentPortalCodes` (
  `enrollmentId` int NOT NULL COMMENT 'Enrollment ID',
  `portalCode` char(50) NOT NULL COMMENT 'PortalCode',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'PersonId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'PersonId of the account that last updated the record',
  PRIMARY KEY (`enrollmentId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores PortalCode information to Enrollment records';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Enrollments`
--

DROP TABLE IF EXISTS `Enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Enrollments` (
  `enrollmentId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `personId` int unsigned NOT NULL COMMENT 'The Person that owns the Enrollment',
  `offeringId` int unsigned NOT NULL COMMENT 'The Offering that the Person is enrolled in',
  `personAssignmentId` int unsigned NOT NULL COMMENT 'PersonOffering for the Enrollment',
  `startedAt` timestamp NULL DEFAULT NULL COMMENT 'The time in which this Enrollment was started',
  `affirmedAt` timestamp NULL DEFAULT NULL COMMENT 'The time in which this Enrollment was affirmed',
  `completedAt` timestamp NULL DEFAULT NULL COMMENT 'time the Enrollment was completed and just before the certificates service call',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentId`),
  UNIQUE KEY `UQ_personAssignmentId` (`personAssignmentId`),
  KEY `FK_PersonAccounts_personId` (`personId`),
  KEY `FK_Offerings_offeringId` (`offeringId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB AUTO_INCREMENT=42629443 DEFAULT CHARSET=utf8mb3 COMMENT='The instance of a Person launching an Offering';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentSettings`
--

DROP TABLE IF EXISTS `EnrollmentSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentSettings` (
  `enrollmentId` int unsigned NOT NULL COMMENT 'enrollment',
  `settings` text NOT NULL COMMENT 'json encoded settings',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Enrollment settings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EnrollmentsHistory`
--

DROP TABLE IF EXISTS `EnrollmentsHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrollmentsHistory` (
  `enrollmentId` int unsigned NOT NULL COMMENT 'Enrollment ID',
  `personId` int unsigned NOT NULL COMMENT 'Person ID',
  `personAssignmentId` int unsigned NOT NULL COMMENT 'Person Assignment ID',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  PRIMARY KEY (`enrollmentId`,`createdAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Enrollments History';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ExamWeighting`
--

DROP TABLE IF EXISTS `ExamWeighting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ExamWeighting` (
  `nodeId` int unsigned NOT NULL COMMENT 'nodeId',
  `weightingNameId` int NOT NULL COMMENT 'weighting name Id',
  `dimensionId` int NOT NULL COMMENT 'dimensionId',
  `count` int NOT NULL COMMENT 'weighted question count',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`weightingNameId`,`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Table that stores exam weight counts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ExamWeightingNames`
--

DROP TABLE IF EXISTS `ExamWeightingNames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ExamWeightingNames` (
  `weightingNameId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'weightingNameId',
  `weightingName` varchar(100) NOT NULL COMMENT 'weighting name',
  `suffix` varchar(45) DEFAULT NULL COMMENT 'Suffix for Weighting Name',
  `weightingParams` varchar(500) NOT NULL COMMENT 'json encoded parameters including nodeRootId, tags, dimension, can be multiple',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`weightingNameId`),
  UNIQUE KEY `UQ_weightingName_suffix` (`weightingName`,`suffix`)
) ENGINE=InnoDB AUTO_INCREMENT=1026 DEFAULT CHARSET=utf8mb3 COMMENT='Lookup table for exam weighting names';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Features`
--

DROP TABLE IF EXISTS `Features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Features` (
  `featureId` int unsigned NOT NULL COMMENT 'Feature ID',
  `name` varchar(100) NOT NULL COMMENT 'Feature Name',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`featureId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Features are enabled by rules';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FederationTokens`
--

DROP TABLE IF EXISTS `FederationTokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FederationTokens` (
  `personId` int unsigned NOT NULL COMMENT 'Foreign key to the PersonAccounts table',
  `token` char(32) NOT NULL COMMENT 'token for providing Person Identity',
  `data` varchar(2500) DEFAULT NULL COMMENT 'Serialized data stored for federation',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  PRIMARY KEY (`personId`),
  UNIQUE KEY `UQ_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores tokens for Persons that federated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FixedTestQuestions`
--

DROP TABLE IF EXISTS `FixedTestQuestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FixedTestQuestions` (
  `fixedTestId` int unsigned NOT NULL COMMENT 'Fixed Test ID',
  `questionId` int unsigned NOT NULL COMMENT 'Question ID',
  `sortOrder` smallint unsigned NOT NULL COMMENT 'Sort Order of Question within Fixed Test',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`fixedTestId`,`questionId`),
  UNIQUE KEY `UQ_fixedTestId_sortOrder` (`fixedTestId`,`sortOrder`),
  KEY `questionId` (`questionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Questions related to FixedTests';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FixedTests`
--

DROP TABLE IF EXISTS `FixedTests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FixedTests` (
  `fixedTestId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Fixed Test ID',
  `offeringDetailId` int unsigned NOT NULL COMMENT 'Offering Detail ID',
  `name` varchar(255) DEFAULT NULL COMMENT 'Fixed Test Name',
  `isShuffled` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether questions will be shuffled',
  `isActive` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Whether Fixed Test Is Active / Displayable',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`fixedTestId`),
  KEY `offeringDetailId` (`offeringDetailId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='Tests with fixed questions stored in FixedTestQuestions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FolderRootFeatures`
--

DROP TABLE IF EXISTS `FolderRootFeatures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FolderRootFeatures` (
  `folderRootId` int unsigned NOT NULL COMMENT 'FolderRoot (layout) that contains features',
  `featureId` int unsigned NOT NULL COMMENT 'Feature that is included in the layout',
  `offeringId` int unsigned NOT NULL DEFAULT '0' COMMENT 'Offering-specific feature or 0 for all features of a type',
  `folderId` int unsigned DEFAULT NULL COMMENT 'Folder holding feature in layout. Null for top depth.',
  `sortOrder` int unsigned DEFAULT NULL COMMENT 'Sort order of the feature within a folder',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`folderRootId`,`featureId`,`offeringId`),
  KEY `FK_featureId` (`featureId`),
  KEY `IX_offeringId` (`offeringId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores position of feature within folder root';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FolderRoots`
--

DROP TABLE IF EXISTS `FolderRoots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FolderRoots` (
  `folderRootId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-Incrementing Primary Key',
  `folderRootName` varchar(50) NOT NULL COMMENT 'The folder root name',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`folderRootId`),
  UNIQUE KEY `folderRootName_UNIQUE` (`folderRootName`)
) ENGINE=InnoDB AUTO_INCREMENT=357 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Folders`
--

DROP TABLE IF EXISTS `Folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Folders` (
  `folderId` int unsigned NOT NULL AUTO_INCREMENT,
  `parentFolderId` int unsigned DEFAULT NULL COMMENT 'FolderId of the parent of this Folder used in the adjacency list model',
  `folderTypeId` tinyint unsigned NOT NULL COMMENT 'type of the Folder',
  `folderRootId` int unsigned DEFAULT NULL,
  `name` varchar(50) NOT NULL COMMENT 'The folder name',
  `lft` int unsigned NOT NULL COMMENT 'Nested set left value',
  `rgt` int unsigned NOT NULL COMMENT 'Nested set right value',
  `height` tinyint unsigned NOT NULL COMMENT 'The length of the longest downward path to a leaf from this Folder',
  `depth` tinyint unsigned NOT NULL COMMENT 'The length of the path to the root of this Folder',
  `sortOrder` int unsigned NOT NULL DEFAULT '0' COMMENT 'sorting position of folder within a folder',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`folderId`),
  UNIQUE KEY `UQ_folderRootId_lft` (`folderRootId`,`lft`),
  UNIQUE KEY `UQ_folderTypeId_name_folderRootId` (`folderTypeId`,`name`,`folderRootId`),
  KEY `FK_folderRootId` (`folderRootId`)
) ENGINE=InnoDB AUTO_INCREMENT=11412 DEFAULT CHARSET=utf8mb3 COMMENT='Describes groupings of related Offering Details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FolderTypes`
--

DROP TABLE IF EXISTS `FolderTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FolderTypes` (
  `folderTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing primary key',
  `name` varchar(50) NOT NULL COMMENT 'The folder type name',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`folderTypeId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COMMENT='Folder types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Glossary`
--

DROP TABLE IF EXISTS `Glossary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Glossary` (
  `glossaryId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `dimensionId` int unsigned NOT NULL COMMENT 'The Dimension that contains the terms and definitions',
  `term` varchar(255) NOT NULL COMMENT 'term being defined by NodeRoot',
  `definition` varchar(1000) NOT NULL COMMENT 'definition of term by NodeRoot',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`glossaryId`),
  KEY `FK_dimensionId` (`dimensionId`)
) ENGINE=InnoDB AUTO_INCREMENT=362746 DEFAULT CHARSET=utf8mb3 COMMENT='Terms and definitions organized by NodeRoot';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `GradingScaleScoreRangeDisplays`
--

DROP TABLE IF EXISTS `GradingScaleScoreRangeDisplays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GradingScaleScoreRangeDisplays` (
  `gradingScaleScoreRangeDisplayId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-increment ID for the grading scale score range displays',
  `gradingScaleScoreId` int unsigned NOT NULL COMMENT 'grading scale score id',
  `minScore` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'grading scale min score',
  `maxScore` tinyint unsigned NOT NULL DEFAULT '100' COMMENT 'grading scale max score',
  `displayScore` tinyint unsigned NOT NULL COMMENT 'grading scale display score',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`gradingScaleScoreRangeDisplayId`),
  UNIQUE KEY `UQ_grading_scale_score_range` (`gradingScaleScoreId`,`minScore`,`maxScore`),
  CONSTRAINT `GradingScaleScoreRangeDisplays_chk_1` CHECK ((`minScore` <= `maxScore`))
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb3 COMMENT='Storing the grading scale score range displays';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `GradingScaleScores`
--

DROP TABLE IF EXISTS `GradingScaleScores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GradingScaleScores` (
  `gradingScaleScoreId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-increment ID for the grading scale scores',
  `name` varchar(255) DEFAULT NULL COMMENT 'name of the grading scale score',
  `attribute` varchar(255) DEFAULT NULL COMMENT 'state of the grading scale score',
  `minRange` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'grading scale min score',
  `maxRange` tinyint unsigned NOT NULL DEFAULT '100' COMMENT 'grading scale max score',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`gradingScaleScoreId`),
  UNIQUE KEY `UQ_name` (`name`),
  CONSTRAINT `GradingScaleScores_chk_1` CHECK ((`minRange` <= `maxRange`))
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 COMMENT='Storing the grading scale scores';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Highlights`
--

DROP TABLE IF EXISTS `Highlights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Highlights` (
  `highlightId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key for highlights',
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'Enrollment Detail Id that the highlights apply to',
  `highlightTypeId` int unsigned NOT NULL COMMENT 'Highlight type Id of highlights',
  `startPosition` int NOT NULL COMMENT 'Start poistion of the highlighting text',
  `endPosition` int NOT NULL COMMENT 'End poistion of the highlighting text',
  `count` int DEFAULT NULL COMMENT 'Total highlights for the test or course',
  `colour` varchar(255) NOT NULL COMMENT 'Colour of the highlighting text',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`highlightId`),
  KEY `FK_enrollmentDetailId` (`enrollmentDetailId`),
  KEY `highlightTypeId` (`highlightTypeId`),
  KEY `IX_enrollmentDetailId` (`enrollmentDetailId` DESC)
) ENGINE=InnoDB AUTO_INCREMENT=561 DEFAULT CHARSET=utf8mb3 COMMENT='Storing text attributes of hightlights';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `HighlightTexts`
--

DROP TABLE IF EXISTS `HighlightTexts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `HighlightTexts` (
  `highlightTextId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key for highlight text',
  `highlightId` int unsigned NOT NULL COMMENT 'Highlight Id of Highlights table',
  `highlightText` text NOT NULL COMMENT 'Highlighted text',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`highlightTextId`),
  KEY `IX_highlightId` (`highlightId`)
) ENGINE=InnoDB AUTO_INCREMENT=561 DEFAULT CHARSET=utf8mb3 COMMENT='To store text related to highlights';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `HighlightTypes`
--

DROP TABLE IF EXISTS `HighlightTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `HighlightTypes` (
  `highlightTypeId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key for highlight types',
  `highlightName` varchar(255) NOT NULL COMMENT 'Name of highlight type',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`highlightTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='Storing the different types of hightlight supported by application';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IdentifiersNotNowLogs`
--

DROP TABLE IF EXISTS `IdentifiersNotNowLogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IdentifiersNotNowLogs` (
  `personId` int unsigned NOT NULL COMMENT 'Person',
  `offeringGroup` varchar(255) NOT NULL COMMENT 'Offering Group',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`personId`,`offeringGroup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores logs for avoiding optional identifiers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ImpersonatorLogs`
--

DROP TABLE IF EXISTS `ImpersonatorLogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ImpersonatorLogs` (
  `impersonatorLogId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `impersonatorId` int unsigned DEFAULT NULL COMMENT 'impersonator personId logged in for the Session',
  `personId` int unsigned DEFAULT NULL COMMENT 'student personId logged in for the Session',
  `isWrite` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Whether Impersonated with Read or Write, if it is 1 it is a write permission',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`impersonatorLogId`),
  KEY `IX_impersonatorId` (`impersonatorId`),
  KEY `personId` (`personId`)
) ENGINE=InnoDB AUTO_INCREMENT=928978 DEFAULT CHARSET=utf8mb3 COMMENT='Impersonator Logs';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Importers`
--

DROP TABLE IF EXISTS `Importers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Importers` (
  `importerId` tinyint unsigned NOT NULL COMMENT 'Importer ID',
  `name` varchar(255) NOT NULL COMMENT 'Importer Name',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`importerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Importers for Content Bridge admin';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `InstructorEnrollments`
--

DROP TABLE IF EXISTS `InstructorEnrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InstructorEnrollments` (
  `instructorPersonId` int unsigned NOT NULL COMMENT 'instructor PersonAccount managing the Enrollments',
  `enrollmentId` int unsigned NOT NULL COMMENT 'Enrollment managed by instructor PersonAccount',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`instructorPersonId`,`enrollmentId`),
  KEY `FK_Enrollments_enrollmentId` (`enrollmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Join table between instructor PersonAccounts and Enrollments';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `InstructorLinkProductMessages`
--

DROP TABLE IF EXISTS `InstructorLinkProductMessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InstructorLinkProductMessages` (
  `productGroup` varchar(50) NOT NULL COMMENT 'Product Group Identifier',
  `productLevel` varchar(20) NOT NULL COMMENT 'Product Level Identifier',
  `productSubLevel` varchar(20) NOT NULL COMMENT 'Product Sub-Level',
  `discussionTypeId` tinyint unsigned NOT NULL COMMENT 'Discussion Type Pertaining to Message',
  `title` varchar(30) DEFAULT NULL COMMENT 'Title for discussion type tab',
  `message` varchar(500) DEFAULT NULL COMMENT 'Message for product line and discussionType',
  `email` varchar(255) DEFAULT NULL COMMENT 'Instructor email address',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`productGroup`,`productLevel`,`productSubLevel`,`discussionTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Guiding messages in InstructorLink';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `InstructorsOnline`
--

DROP TABLE IF EXISTS `InstructorsOnline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InstructorsOnline` (
  `instructorId` int unsigned NOT NULL COMMENT 'Instructor',
  `productGroup` varchar(50) NOT NULL COMMENT 'Product Group',
  `productLevel` varchar(20) NOT NULL COMMENT 'Product Level',
  `isOnline` tinyint(1) NOT NULL COMMENT 'If instructor is online',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`instructorId`,`productGroup`,`productLevel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Table that stores online instructors for instructor link plus';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Media`
--

DROP TABLE IF EXISTS `Media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Media` (
  `mediaId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `hash` char(32) NOT NULL COMMENT 'hash used to uniquely identify the media',
  `sourceId` tinyint DEFAULT NULL COMMENT 'Stores Id of source of the media file where it is being stored',
  `filename` varchar(50) DEFAULT NULL COMMENT 'file name for download',
  `extension` varchar(20) NOT NULL COMMENT 'suffix of the filename to indicate the Media format',
  `isSecure` tinyint unsigned NOT NULL COMMENT 'Does file require authorization?',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`mediaId`),
  UNIQUE KEY `UQ_sourceId_hash` (`sourceId`,`hash`),
  KEY `FK_MediaSources_sourceId` (`sourceId`)
) ENGINE=InnoDB AUTO_INCREMENT=188591 DEFAULT CHARSET=utf8mb3 COMMENT='Images / Audio / Video contained in Contents';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MediaSources`
--

DROP TABLE IF EXISTS `MediaSources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MediaSources` (
  `sourceId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing primary key',
  `name` varchar(50) NOT NULL COMMENT 'The media source type name',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`sourceId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='Media Sources';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ModuleLinkPageParams`
--

DROP TABLE IF EXISTS `ModuleLinkPageParams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ModuleLinkPageParams` (
  `moduleLinkId` int unsigned NOT NULL COMMENT 'moduleLinkId foreign key',
  `key` varchar(100) NOT NULL COMMENT 'Key name for data',
  `value` varchar(255) NOT NULL COMMENT 'Page param value',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`moduleLinkId`,`key`,`value`),
  KEY `key` (`key`),
  KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Module Link Page Params';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ModuleLinks`
--

DROP TABLE IF EXISTS `ModuleLinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ModuleLinks` (
  `moduleLinkId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `linkName` varchar(100) NOT NULL COMMENT 'Module link display name',
  `description` varchar(255) DEFAULT NULL COMMENT 'Module link description',
  `offeringDetailId` int unsigned NOT NULL COMMENT 'The OfferingDetail for ModuleLink',
  `pageType` varchar(100) NOT NULL COMMENT 'Page type as string for module link',
  `hash` char(32) NOT NULL COMMENT 'MD5 of the serialized data, used for keeping from entering duplicate data',
  `isArchived` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Whether module link is archived',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`moduleLinkId`),
  KEY `offeringDetailId` (`offeringDetailId`),
  KEY `hash` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=57818 DEFAULT CHARSET=utf8mb3 COMMENT='Module Link IDs';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NodeAttributes`
--

DROP TABLE IF EXISTS `NodeAttributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NodeAttributes` (
  `nodeId` int unsigned NOT NULL COMMENT 'nodeId to which the NodeAttribute applies for the key',
  `key` varchar(100) NOT NULL COMMENT 'key for the NodeAttribute for the nodeId',
  `value` varchar(255) NOT NULL COMMENT 'value of the NodeAttribute for a nodeId and key',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`nodeId`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Key/value pair table for storing things about node';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NodeClassifications`
--

DROP TABLE IF EXISTS `NodeClassifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NodeClassifications` (
  `nodeClassificationId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(255) NOT NULL COMMENT 'name of the NodeClassification',
  `description` varchar(255) NOT NULL COMMENT 'description of the NodeClassification',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`nodeClassificationId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COMMENT='Classifications of Nodes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NodeDifficultyStatistics`
--

DROP TABLE IF EXISTS `NodeDifficultyStatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NodeDifficultyStatistics` (
  `nodeId` int unsigned NOT NULL COMMENT 'Node',
  `dimensionId` int unsigned NOT NULL COMMENT 'Dimension',
  `difficultyId` int unsigned NOT NULL COMMENT 'Question difficultyId',
  `count` int unsigned NOT NULL DEFAULT '0' COMMENT 'Question count for node based on the dimension and difficulty level',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`nodeId`,`dimensionId`,`difficultyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NodeDimensionReferences`
--

DROP TABLE IF EXISTS `NodeDimensionReferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NodeDimensionReferences` (
  `nodeId` int unsigned NOT NULL COMMENT 'Node ID',
  `dimensionId` int unsigned NOT NULL COMMENT 'Dimension ID',
  `foreignId` varchar(255) NOT NULL COMMENT 'ID value from the foreign system',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`nodeId`,`dimensionId`),
  KEY `IX_foreignId` (`foreignId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Lookup table for foreign ID by Node and Dimension';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NodeDimensions`
--

DROP TABLE IF EXISTS `NodeDimensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NodeDimensions` (
  `nodeId` int unsigned NOT NULL COMMENT 'Node the Content is attached to described by Dimension',
  `dimensionId` int unsigned NOT NULL COMMENT 'Dimension to describe the Node to Content relationship',
  `contentId` int unsigned NOT NULL COMMENT 'Content attached to Node described by Dimension',
  `nodeClassificationId` int unsigned NOT NULL COMMENT 'node classification specific to dimension',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`nodeId`,`dimensionId`),
  KEY `FK_Dimensions_dimensionId` (`dimensionId`),
  KEY `FK_Contents_contentId` (`contentId`),
  KEY `FK_NodeClassifications_nodeClassificationId` (`nodeClassificationId`),
  KEY `idx_nodeDimensions_contentId` (`contentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Link Content to Nodes through Dimensions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NodeDimensionsHistory`
--

DROP TABLE IF EXISTS `NodeDimensionsHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NodeDimensionsHistory` (
  `nodeId` int unsigned NOT NULL COMMENT 'Node ID',
  `dimensionId` int unsigned NOT NULL COMMENT 'Dimension ID',
  `contentId` int unsigned NOT NULL COMMENT 'Content ID',
  `nodeClassificationId` int unsigned NOT NULL COMMENT 'Node Classification ID',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'Person ID that created the record',
  PRIMARY KEY (`nodeId`,`dimensionId`,`createdAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='History of node''s content (except most recent)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NodeGraph`
--

DROP TABLE IF EXISTS `NodeGraph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NodeGraph` (
  `startNodeId` int unsigned NOT NULL COMMENT 'start Node of the edge in the NodeGraph; LO or task Node',
  `endNodeId` int unsigned NOT NULL COMMENT 'end Node of the edge in the NodeGraph; topic, LO, or task Node',
  `sortOrder` int unsigned NOT NULL COMMENT 'sortOrder for the end Node attached to the start Node',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`startNodeId`,`endNodeId`),
  KEY `FK_Nodes_endNodeId` (`endNodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Join table linking LO or task Nodes to other Nodes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NodeRoots`
--

DROP TABLE IF EXISTS `NodeRoots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NodeRoots` (
  `nodeRootId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Surrogate primary key',
  `name` varchar(500) NOT NULL COMMENT 'name of the NodeRoot',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`nodeRootId`)
) ENGINE=InnoDB AUTO_INCREMENT=90055600 DEFAULT CHARSET=utf8mb3 COMMENT='The root of a tree of Nodes that links to an Offering';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Nodes`
--

DROP TABLE IF EXISTS `Nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Nodes` (
  `nodeId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `nodeRootId` int unsigned NOT NULL COMMENT 'NodeRoot for this Node',
  `parentNodeId` int unsigned DEFAULT NULL COMMENT 'nodeId of the parent of this Node used in the adjacency list model',
  `nodeTypeId` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'type of the Node',
  `lft` int unsigned NOT NULL COMMENT 'Nested set left value',
  `rgt` int unsigned NOT NULL COMMENT 'Nested set right value',
  `page` smallint unsigned NOT NULL DEFAULT '1' COMMENT 'sort order relative to node parent',
  `depth` tinyint unsigned NOT NULL COMMENT 'The length of the path to the root of this Node',
  `height` tinyint unsigned NOT NULL COMMENT 'The length of the longest downward path to a leaf from this Node',
  `title` varchar(500) NOT NULL COMMENT 'The title of the Node',
  `shortTitle` varchar(30) DEFAULT NULL COMMENT 'A shortened title for the Node',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`nodeId`),
  UNIQUE KEY `UQ_nodeRootId_lft` (`nodeRootId`,`lft`),
  KEY `FK_Nodes_parentNodeId` (`parentNodeId`),
  KEY `nodeRootId` (`nodeRootId`,`depth`,`lft`,`rgt`,`nodeId`),
  KEY `idx_nodes_nodeRootId_depth_lft_rgt2` (`nodeRootId`,`depth`,`lft`,`rgt`)
) ENGINE=InnoDB AUTO_INCREMENT=5458920 DEFAULT CHARSET=utf8mb3 COMMENT='Nested set and adjacency list models to store Nodes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Nodes_12052023_backup_dba`
--

DROP TABLE IF EXISTS `Nodes_12052023_backup_dba`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Nodes_12052023_backup_dba` (
  `nodeId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `nodeRootId` int unsigned NOT NULL COMMENT 'NodeRoot for this Node',
  `parentNodeId` int unsigned DEFAULT NULL COMMENT 'nodeId of the parent of this Node used in the adjacency list model',
  `nodeTypeId` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'type of the Node',
  `lft` int unsigned NOT NULL COMMENT 'Nested set left value',
  `rgt` int unsigned NOT NULL COMMENT 'Nested set right value',
  `page` smallint unsigned NOT NULL DEFAULT '1' COMMENT 'sort order relative to node parent',
  `depth` tinyint unsigned NOT NULL COMMENT 'The length of the path to the root of this Node',
  `height` tinyint unsigned NOT NULL COMMENT 'The length of the longest downward path to a leaf from this Node',
  `title` varchar(500) NOT NULL COMMENT 'The title of the Node',
  `shortTitle` varchar(30) DEFAULT NULL COMMENT 'A shortened title for the Node',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`nodeId`),
  UNIQUE KEY `UQ_nodeRootId_lft` (`nodeRootId`,`lft`),
  KEY `FK_Nodes1_parentNodeId` (`parentNodeId`)
) ENGINE=InnoDB AUTO_INCREMENT=5106012 DEFAULT CHARSET=utf8mb3 COMMENT='Nested set and adjacency list models to store Nodes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NodeStatistics`
--

DROP TABLE IF EXISTS `NodeStatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NodeStatistics` (
  `nodeId` int unsigned NOT NULL COMMENT 'node source for the statistics',
  `dimensionId` int unsigned NOT NULL COMMENT 'Dimension to which the statistics apply',
  `nodeCount` smallint unsigned NOT NULL COMMENT 'count of self plus children',
  `durationSeconds` int unsigned NOT NULL COMMENT 'duration of self plus children',
  `questionCount` smallint unsigned NOT NULL COMMENT 'total number of questions within a node and its decendants',
  `hasItemSet` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether the node has an itemset question',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`nodeId`,`dimensionId`),
  KEY `FK_Dimensions_dimensionId` (`dimensionId`),
  KEY `ix_nodestatistics_01` (`dimensionId`,`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Aggregated statistics for Node and descendants by Dimension';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NodeStatistics_12052023_backup_dba`
--

DROP TABLE IF EXISTS `NodeStatistics_12052023_backup_dba`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NodeStatistics_12052023_backup_dba` (
  `nodeId` int unsigned NOT NULL COMMENT 'node source for the statistics',
  `dimensionId` int unsigned NOT NULL COMMENT 'Dimension to which the statistics apply',
  `nodeCount` smallint unsigned NOT NULL COMMENT 'count of self plus children',
  `durationSeconds` int unsigned NOT NULL COMMENT 'duration of self plus children',
  `questionCount` smallint unsigned NOT NULL COMMENT 'total number of questions within a node and its decendants',
  `hasItemSet` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether the node has an itemset question',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`nodeId`,`dimensionId`),
  KEY `FK1_Dimensions_dimensionId` (`dimensionId`),
  KEY `ix1_nodestatistics_01` (`dimensionId`,`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Aggregated statistics for Node and descendants by Dimension';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NodeTagDifficultyStatistics`
--

DROP TABLE IF EXISTS `NodeTagDifficultyStatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NodeTagDifficultyStatistics` (
  `nodeId` int unsigned NOT NULL COMMENT 'Node',
  `dimensionId` int unsigned NOT NULL COMMENT 'Dimension',
  `difficultyId` int unsigned NOT NULL COMMENT 'Question difficultyId',
  `questionTag` varchar(100) NOT NULL COMMENT 'Question tag',
  `count` int unsigned NOT NULL DEFAULT '0' COMMENT 'Question count for node based on the dimension and difficulty level',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`nodeId`,`dimensionId`,`difficultyId`,`questionTag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NodeTagStatistics`
--

DROP TABLE IF EXISTS `NodeTagStatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NodeTagStatistics` (
  `nodeId` int unsigned NOT NULL COMMENT 'node source for the statistics',
  `dimensionId` int unsigned NOT NULL COMMENT 'dimensionId',
  `questionTag` varchar(100) NOT NULL COMMENT 'Node question tag',
  `questionCount` smallint unsigned NOT NULL COMMENT 'total number of questions within a node and its decendants filtered by questionTag',
  `hasItemSet` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether the node has an itemset question',
  `nodeCount` smallint unsigned NOT NULL COMMENT 'count of self plus children',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`nodeId`,`dimensionId`,`questionTag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='stores aggregated statistics for a node and its decendants for questionTag';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NodeTaxonomy`
--

DROP TABLE IF EXISTS `NodeTaxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NodeTaxonomy` (
  `nodeId` int unsigned NOT NULL COMMENT 'Node ID',
  `taxonomyTypeId` tinyint unsigned NOT NULL COMMENT 'Taxonomy Type',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`nodeId`),
  KEY `FK_taxonomyTypeId` (`taxonomyTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Node Taxonomy Types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NodeTypes`
--

DROP TABLE IF EXISTS `NodeTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NodeTypes` (
  `nodeTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(255) NOT NULL COMMENT 'name of the NodeType',
  `description` varchar(255) NOT NULL COMMENT 'description of the NodeType',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`nodeTypeId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='Types of Nodes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NotificationOfferings`
--

DROP TABLE IF EXISTS `NotificationOfferings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NotificationOfferings` (
  `notificationId` int unsigned NOT NULL COMMENT 'Notification',
  `offeringId` int unsigned NOT NULL COMMENT 'Offering',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`notificationId`,`offeringId`),
  KEY `FK_Offerings_offeringId` (`offeringId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Relationships between notification and offerings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Notifications`
--

DROP TABLE IF EXISTS `Notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Notifications` (
  `notificationId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-Incrementing Notification ID',
  `text` varchar(255) NOT NULL COMMENT 'text the Notification',
  `url` varchar(255) NOT NULL COMMENT 'url of the Notification',
  `includeNewEnrollments` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Notification should be sent to new enrollments',
  `startsAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the Notification will be sent out',
  `expiresAt` timestamp NULL DEFAULT NULL COMMENT 'time the Notification expires',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`notificationId`),
  UNIQUE KEY `UQ_text_url_startsAt` (`text`,`url`,`startsAt`),
  KEY `createdBy` (`createdBy`)
) ENGINE=InnoDB AUTO_INCREMENT=229944 DEFAULT CHARSET=utf8mb3 COMMENT='List of Notifications';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OfferingDetailActivityGroups`
--

DROP TABLE IF EXISTS `OfferingDetailActivityGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OfferingDetailActivityGroups` (
  `offeringDetailId` int unsigned NOT NULL COMMENT 'OfferingDetail relating to ActivityGroup',
  `activityGroupId` int unsigned NOT NULL COMMENT 'ActivityGroup relating to OfferingDetail',
  `sortOrder` tinyint unsigned NOT NULL COMMENT 'sort order for the NodeRoots attached to a OfferingDetail',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`offeringDetailId`,`activityGroupId`),
  UNIQUE KEY `UQ_offeringDetailId_sortOrder` (`offeringDetailId`,`sortOrder`),
  KEY `FK_activityGroupId` (`activityGroupId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Instance of an ActivityGroup in an OfferingDetail';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OfferingDetailClassifications`
--

DROP TABLE IF EXISTS `OfferingDetailClassifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OfferingDetailClassifications` (
  `offeringDetailId` int unsigned NOT NULL COMMENT 'Offering Detail ID',
  `offeringDetailSubTypeId` tinyint unsigned NOT NULL COMMENT 'Offering Detail Classification ID',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`offeringDetailId`),
  KEY `offeringDetailSubTypeId` (`offeringDetailSubTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Offering Detail Classifications';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OfferingDetailNodeRoots`
--

DROP TABLE IF EXISTS `OfferingDetailNodeRoots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OfferingDetailNodeRoots` (
  `offeringDetailId` int unsigned NOT NULL COMMENT 'OfferingDetail relating to NodeRoot described by Dimension',
  `nodeRootId` int unsigned NOT NULL COMMENT 'NodeRoot relating to OfferingDetail described by Dimension',
  `dimensionId` int unsigned NOT NULL COMMENT 'Dimension describing the OfferingDetail to NodeRoot relationship',
  `sortOrder` tinyint unsigned NOT NULL COMMENT 'sort order for the NodeRoots attached to a OfferingDetail',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`offeringDetailId`,`nodeRootId`),
  KEY `FK_NodeRoots_nodeRootId` (`nodeRootId`),
  KEY `FK_Dimensions_dimensionId` (`dimensionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Instance of a NodeRoot in an OfferingDetail';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OfferingDetails`
--

DROP TABLE IF EXISTS `OfferingDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OfferingDetails` (
  `offeringDetailId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `offeringDetailTypeId` tinyint unsigned NOT NULL COMMENT 'type of the OfferingDetail',
  `name` varchar(255) NOT NULL COMMENT 'name of the OfferingDetail',
  `isArchived` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If OfferingDetails is archived',
  `showProgress` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If OfferingDetails can show progress metrics or not',
  `includeVideos` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Whether to include in video repository',
  `isMobileEnabled` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'Whether it is enabled for mobile',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`offeringDetailId`),
  KEY `FK_OfferingDetailTypes_offeringDetailTypeId` (`offeringDetailTypeId`),
  KEY `IX_isArchived` (`isArchived`)
) ENGINE=InnoDB AUTO_INCREMENT=183430 DEFAULT CHARSET=utf8mb3 COMMENT='Details or components of an Offering';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OfferingDetailSubTypes`
--

DROP TABLE IF EXISTS `OfferingDetailSubTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OfferingDetailSubTypes` (
  `offeringDetailSubTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Offering Detail Sub Type ID',
  `name` varchar(100) NOT NULL COMMENT 'Offering Detail Sub Type Name',
  `offeringDetailTypeId` tinyint unsigned NOT NULL COMMENT 'Offering Detail Type ID',
  `nodeClassificationId` tinyint unsigned DEFAULT NULL COMMENT 'Node Classification ID',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`offeringDetailSubTypeId`),
  KEY `offeringDetailTypeId` (`offeringDetailTypeId`),
  KEY `nodeClassificationId` (`nodeClassificationId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COMMENT='Offering Detail SubTypes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OfferingDetailTypes`
--

DROP TABLE IF EXISTS `OfferingDetailTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OfferingDetailTypes` (
  `offeringDetailTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(255) NOT NULL COMMENT 'name of the OfferingDetailType',
  `description` varchar(255) NOT NULL COMMENT 'description of the OfferingDetailType',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`offeringDetailTypeId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3 COMMENT='Types of OfferingDetails';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OfferingOfferingDetails`
--

DROP TABLE IF EXISTS `OfferingOfferingDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OfferingOfferingDetails` (
  `offeringId` int unsigned NOT NULL COMMENT 'The Offering to which the OfferingDetail applies',
  `offeringDetailId` int unsigned NOT NULL COMMENT 'The OfferingDetail contained by an Offering',
  `folderId` int unsigned DEFAULT NULL,
  `sortOrder` int unsigned NOT NULL DEFAULT '0' COMMENT 'sorting position of offering detail within a folder',
  `relation` varchar(255) DEFAULT NULL COMMENT 'Relates details within an offering',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`offeringId`,`offeringDetailId`),
  KEY `FK_OfferingDetails_offeringDetailId` (`offeringDetailId`),
  KEY `FK_Folders_folderId` (`folderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Join table linking Offerings to OfferingDetails';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Offerings`
--

DROP TABLE IF EXISTS `Offerings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Offerings` (
  `offeringId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `productGroup` varchar(50) NOT NULL COMMENT 'ProductGroup from BDS Product',
  `productLevel` varchar(20) NOT NULL COMMENT 'Levels from BDS Product',
  `name` varchar(255) NOT NULL COMMENT 'The name for the Offering',
  `description` varchar(2000) NOT NULL COMMENT 'The description of the offering',
  `folderRootId` int unsigned NOT NULL DEFAULT '1' COMMENT 'Folder Root assigned to the offering',
  `isAnchored` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Whether offering is anchored',
  `isArchived` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Whether offering is archived',
  `isPublished` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Whether offering is published or not',
  `firstEnrolledAt` timestamp NULL DEFAULT NULL COMMENT 'Time the first enrollment occured for this Offering',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`offeringId`),
  KEY `IX_productGroup_productLevel` (`productGroup`,`productLevel`),
  KEY `IX_productLevel` (`productLevel`),
  KEY `FK_FolderRoots_folderRootId` (`folderRootId`),
  KEY `idx_offerings_productgroup_level` (`productGroup`,`productLevel`)
) ENGINE=InnoDB AUTO_INCREMENT=175720 DEFAULT CHARSET=utf8mb3 COMMENT='Collection of online content associated with a purchase';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PersonAccountAclRoles`
--

DROP TABLE IF EXISTS `PersonAccountAclRoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PersonAccountAclRoles` (
  `personId` int unsigned NOT NULL COMMENT 'PersonAccount assigned an AclRole.',
  `aclRoleId` smallint unsigned NOT NULL COMMENT 'AclRole assigned to the PersonAccount',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`personId`,`aclRoleId`),
  KEY `FK_PersonAccounts_personId` (`personId`),
  KEY `FK_AclRoles_aclRoleId` (`aclRoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='PersonAccounts mapped to AclRoles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PersonAccountHistory`
--

DROP TABLE IF EXISTS `PersonAccountHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PersonAccountHistory` (
  `personAccountHistoryId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `personId` int unsigned NOT NULL COMMENT 'personId of the PersonAccounts record',
  `username` varchar(50) DEFAULT NULL COMMENT 'NEW username of the PersonAccounts record',
  `password` varchar(512) DEFAULT NULL COMMENT 'Bcrypt hash of the password',
  `displayName` varchar(50) NOT NULL COMMENT 'NEW displayName of the PersonAccounts record',
  `lockoutStartTime` timestamp NULL DEFAULT NULL COMMENT 'NEW lockoutStartTime of the PersonAccounts record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the PersonAccounts record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the PersonAccounts record',
  `dbUser` varchar(255) NOT NULL COMMENT 'Value of USER() when the trigger is executed on the PersonAccounts table',
  PRIMARY KEY (`personAccountHistoryId`),
  KEY `FK_PersonAccounts_personId` (`personId`)
) ENGINE=InnoDB AUTO_INCREMENT=12686982 DEFAULT CHARSET=utf8mb3 COMMENT='Stores history of changes made to the PersonAccounts table.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PersonAccounts`
--

DROP TABLE IF EXISTS `PersonAccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PersonAccounts` (
  `personId` int unsigned NOT NULL COMMENT 'Unique identifer from the Person system',
  `lastViewedEnrollmentDetailId` int unsigned DEFAULT NULL COMMENT 'The last viewed EnrollmentDetail',
  `lastSecurityChallengeStatusId` tinyint unsigned DEFAULT NULL COMMENT 'status of the last SecurityChallenge issued to the Person',
  `themeId` tinyint unsigned NOT NULL DEFAULT '2' COMMENT 'Theme that this person will use within the LMS',
  `username` varchar(50) DEFAULT NULL COMMENT 'Unique username the Person uses to log into the LMS',
  `password` varchar(512) DEFAULT NULL COMMENT 'Bcrypt hash of the password',
  `displayName` varchar(50) DEFAULT NULL COMMENT 'Display name or "nickname" used for display purposes in the LMS',
  `currentProductGroup` varchar(50) DEFAULT NULL COMMENT 'ProductGroup from BDS Product currently selected by the Person',
  `currentProductLevel` varchar(20) DEFAULT NULL COMMENT 'Levels from BDS Product currently selected by the Person',
  `lastLoginAt` timestamp NULL DEFAULT NULL COMMENT 'The last time the Person logged into the LMS',
  `lastUrl` varchar(255) DEFAULT NULL COMMENT 'most recent URL student visited excluding rare exceptions',
  `passwordUpdatedAt` timestamp NULL DEFAULT NULL COMMENT 'The time the password was last updated',
  `failedLoginAttempts` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Count of how many times this Person has entered their username with an incorrect password',
  `lockoutStartTime` timestamp NULL DEFAULT NULL COMMENT 'The time the account was locked due to too many failed login attempts',
  `unreadNotificationCount` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'count of unread Notifications',
  `nextNotificationSendTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `emailNotifications` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Flag to determine if user receives email notifications',
  `isActive` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Flag for the account being active/inactive',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`personId`),
  UNIQUE KEY `UQ_username` (`username`),
  KEY `FK_EnrollmentDetails_lastViewedEnrollmentDetailId` (`lastViewedEnrollmentDetailId`),
  KEY `FK_SecurityChallengeStatuses_lastSecurityChallengeStatusId` (`lastSecurityChallengeStatusId`),
  KEY `IX_displayName` (`displayName`),
  KEY `FK_Themes_themeId` (`themeId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Holds authentication data for the LMS keyed by Person.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PersonAccountTokens`
--

DROP TABLE IF EXISTS `PersonAccountTokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PersonAccountTokens` (
  `personId` int unsigned NOT NULL COMMENT 'Foreign key to the PersonAccounts table',
  `token` char(32) NOT NULL COMMENT 'token for Person creation',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  PRIMARY KEY (`personId`) USING BTREE,
  UNIQUE KEY `UQ_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores tokens for Persons that need to be created.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PersonActivities`
--

DROP TABLE IF EXISTS `PersonActivities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PersonActivities` (
  `personActivityId` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `calendarId` int unsigned NOT NULL COMMENT 'Calender ID',
  `activityId` int unsigned NOT NULL COMMENT 'Activity ID',
  `date` date NOT NULL COMMENT 'Date of activity assigned',
  `activityDuration` smallint NOT NULL COMMENT 'Duration in minutes consider on activity day',
  `hasPrevious` tinyint(1) NOT NULL COMMENT 'Whether activity carried over from the previous day',
  `hasNext` tinyint(1) NOT NULL COMMENT 'Whether activity moved to the next day',
  `isMultiDayActivity` tinyint(1) NOT NULL COMMENT 'Whether multiday activity',
  `isVisible` tinyint(1) NOT NULL COMMENT 'Whether activity is displayed to student on activity date',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`personActivityId`),
  UNIQUE KEY `UC_PersonActivities` (`calendarId`,`activityId`,`date`),
  KEY `FK_activityId` (`activityId`),
  KEY `comp_pa_calendar` (`calendarId`,`date`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB AUTO_INCREMENT=716856158 DEFAULT CHARSET=utf8mb3 COMMENT='Scheduled Activities details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PersonActivitiesTrav`
--

DROP TABLE IF EXISTS `PersonActivitiesTrav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PersonActivitiesTrav` (
  `personActivityId` bigint unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PersonEvents`
--

DROP TABLE IF EXISTS `PersonEvents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PersonEvents` (
  `personEventId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `calendarId` int unsigned NOT NULL COMMENT 'Calendar the PersonEvent belongs to',
  `nodeId` int unsigned NOT NULL COMMENT 'task type Node for the PersonEvent',
  `startTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the PersonEvent starts',
  `durationSeconds` mediumint unsigned NOT NULL DEFAULT '0' COMMENT 'duration in seconds of the PersonEvent',
  `title` varchar(255) NOT NULL COMMENT 'title of the PersonEvent',
  `shortTitle` varchar(30) DEFAULT NULL COMMENT 'A shortened title for the PersonEvent',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`personEventId`),
  UNIQUE KEY `UQ_calendarId_nodeId` (`calendarId`,`nodeId`),
  KEY `FK_Nodes_nodeId` (`nodeId`),
  KEY `IX_calendarId_startTime_personEventId` (`calendarId`,`startTime`,`personEventId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB AUTO_INCREMENT=323743682 DEFAULT CHARSET=utf8mb3 COMMENT='Calendar of tasks and custom events by PersonAccount';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PersonForumSettings`
--

DROP TABLE IF EXISTS `PersonForumSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PersonForumSettings` (
  `personId` int unsigned NOT NULL COMMENT 'Person',
  `displayName` varchar(50) NOT NULL COMMENT 'Forum display name',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`personId`),
  UNIQUE KEY `UQ_displayName` (`displayName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Person forum settings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PersonNotifications`
--

DROP TABLE IF EXISTS `PersonNotifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PersonNotifications` (
  `personNotificationId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `personId` int unsigned NOT NULL COMMENT 'PersonAccount to whom the Notification is sent',
  `notificationId` int unsigned NOT NULL COMMENT 'Notification ID',
  `isRead` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'has the notification been read?',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`personNotificationId`),
  KEY `FK_Notifications_notificationId` (`notificationId`),
  KEY `IX_personId_notificationId` (`personId`,`notificationId`)
) ENGINE=InnoDB AUTO_INCREMENT=2380983 DEFAULT CHARSET=utf8mb3 COMMENT='List of Notifications by PersonAccount';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PersonOfferingGroupSettings`
--

DROP TABLE IF EXISTS `PersonOfferingGroupSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PersonOfferingGroupSettings` (
  `personId` int unsigned NOT NULL COMMENT 'Person',
  `offeringGroup` varchar(255) NOT NULL COMMENT 'Offering group',
  `dashboardViewId` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'Default dashboard view',
  `myProgressToggleFlag` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`personId`,`offeringGroup`),
  KEY `FK_dashboardViewId` (`dashboardViewId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Person offering group settings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PersonPasswordResetTokens`
--

DROP TABLE IF EXISTS `PersonPasswordResetTokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PersonPasswordResetTokens` (
  `personId` int unsigned NOT NULL COMMENT 'Foreign key to the PersonAccounts table',
  `token` char(32) NOT NULL COMMENT 'Security token required to reset password',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  PRIMARY KEY (`personId`),
  UNIQUE KEY `UQ_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores tokens for PersonAccounts that need password resets.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PersonSecurityAnswers`
--

DROP TABLE IF EXISTS `PersonSecurityAnswers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PersonSecurityAnswers` (
  `personId` int unsigned NOT NULL COMMENT 'Foreign key to the PersonAccounts table',
  `securityQuestionId` tinyint unsigned NOT NULL COMMENT 'Foreign key to the SecurityQuestions table',
  `answer` char(32) NOT NULL COMMENT 'Hash of the answer to the question in the SecurityQuestions record',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`personId`,`securityQuestionId`),
  KEY `FK_SecurityQuestions_securityQuestionId` (`securityQuestionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A join table linking PersonAccounts to SecurityQuestions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ProctorExamSites`
--

DROP TABLE IF EXISTS `ProctorExamSites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProctorExamSites` (
  `proctorExamSiteId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(255) NOT NULL COMMENT 'The name of the ProctorExamSite',
  `description` varchar(255) NOT NULL COMMENT 'The description of the ProctorExamSite',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`proctorExamSiteId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COMMENT='Proctor Exam Sites';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ProctorIdentificationTypes`
--

DROP TABLE IF EXISTS `ProctorIdentificationTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProctorIdentificationTypes` (
  `proctorIdentificationTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(255) NOT NULL COMMENT 'The name of the ProctorIdentificationType',
  `description` varchar(255) NOT NULL COMMENT 'The description of the ProctorIdentificationType',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`proctorIdentificationTypeId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COMMENT='Proctor Identification Types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ProctortrackOnboardingStatuses`
--

DROP TABLE IF EXISTS `ProctortrackOnboardingStatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProctortrackOnboardingStatuses` (
  `personId` int unsigned NOT NULL COMMENT 'Person',
  `proctortrackStatusId` tinyint unsigned NOT NULL COMMENT 'Proctortrack status',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`personId`,`createdAt`),
  KEY `proctortrackStatusId` (`proctortrackStatusId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Proctortrack onboarding statuses';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ProctortrackStatuses`
--

DROP TABLE IF EXISTS `ProctortrackStatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProctortrackStatuses` (
  `proctortrackStatusId` tinyint unsigned NOT NULL COMMENT 'Proctortrack status ID',
  `status` varchar(20) NOT NULL DEFAULT 'pending' COMMENT 'Proctortrack status',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`proctortrackStatusId`),
  UNIQUE KEY `UQ_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Proctortrack statuses';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ProctortrackTestStatuses`
--

DROP TABLE IF EXISTS `ProctortrackTestStatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProctortrackTestStatuses` (
  `testId` int unsigned NOT NULL COMMENT 'Test',
  `proctortrackStatusId` tinyint unsigned NOT NULL COMMENT 'Proctortrack status',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testId`),
  KEY `proctortrackStatusId` (`proctortrackStatusId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Proctortrack test statuses';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionAssignments`
--

DROP TABLE IF EXISTS `QuestionAssignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionAssignments` (
  `questionAssignmentId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `questionId` int unsigned NOT NULL COMMENT 'Question that is assigned to Content',
  `contentId` int unsigned NOT NULL COMMENT 'Content which is assigned a QuestionSet',
  `questionDifficultyId` tinyint unsigned NOT NULL COMMENT 'difficulty of the Question when it appiles to the Content',
  `referenceCode` varchar(50) DEFAULT NULL COMMENT 'Textual representiation of the QuestionAssignment',
  `sortOrder` int unsigned NOT NULL COMMENT 'order in which the Question is assigned to the Content',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionAssignmentId`),
  UNIQUE KEY `UQ_questionId_contentId` (`questionId`,`contentId`),
  KEY `FK_Contents_contentId` (`contentId`),
  KEY `FK_QuestionDifficulties_questionDifficultyId` (`questionDifficultyId`)
) ENGINE=InnoDB AUTO_INCREMENT=5425801 DEFAULT CHARSET=utf8mb3 COMMENT='Assigns a Question to Content';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionAttributes`
--

DROP TABLE IF EXISTS `QuestionAttributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionAttributes` (
  `questionId` int unsigned NOT NULL COMMENT 'questionId of the Question',
  `dimensionId` int unsigned NOT NULL COMMENT 'The dimension for which the attribute apply',
  `key` varchar(255) NOT NULL COMMENT 'key for the QuestionAttribute for the questionId',
  `value` varchar(255) NOT NULL COMMENT 'value of the QuestionAttribute for a questionId and key',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionId`,`dimensionId`,`key`,`value`),
  KEY `IX_questionId` (`questionId` DESC),
  KEY `IX_questionId_dimensionId` (`questionId`,`dimensionId`),
  KEY `IX_key_value` (`key`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Storing the question attributes while importing the content';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionBlankAnswerVariations`
--

DROP TABLE IF EXISTS `QuestionBlankAnswerVariations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionBlankAnswerVariations` (
  `questionBlankId` int unsigned NOT NULL COMMENT 'Question blank',
  `answerVariation` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'Answer variation',
  `caseSensitive` tinyint unsigned NOT NULL COMMENT 'Whether answer variation is case sensitive',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionBlankId`,`answerVariation`),
  KEY `FK_QuestionBlanks_questionBlankId` (`questionBlankId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='The answer variations for the blanks of fill-in-the-blank questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionBlanks`
--

DROP TABLE IF EXISTS `QuestionBlanks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionBlanks` (
  `questionBlankId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Question blank',
  `questionId` int unsigned NOT NULL COMMENT 'Question',
  `sortOrder` tinyint unsigned NOT NULL COMMENT 'Sort order of blank within question',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionBlankId`),
  UNIQUE KEY `UQ_questionId_sortOrder` (`questionId`,`sortOrder`),
  KEY `FK_Questions_questionId` (`questionId`)
) ENGINE=InnoDB AUTO_INCREMENT=2030 DEFAULT CHARSET=utf8mb3 COMMENT='The blanks for fill-in-the-blank questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionChildren`
--

DROP TABLE IF EXISTS `QuestionChildren`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionChildren` (
  `parentQuestionId` int unsigned NOT NULL COMMENT 'questionId of the QuestionSet',
  `questionId` int unsigned NOT NULL COMMENT 'questionId of the Question',
  `contentId` int unsigned NOT NULL DEFAULT '0' COMMENT 'content that this question is associated with',
  `sortOrder` tinyint unsigned NOT NULL COMMENT 'Sort order for the Questions contained in a QuestionSet',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`contentId`,`questionId`,`parentQuestionId`),
  KEY `FK_Questions_questionId` (`questionId`),
  KEY `parentQuestionId` (`parentQuestionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Parent Child relations between Questions Sets and Questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionDifficulties`
--

DROP TABLE IF EXISTS `QuestionDifficulties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionDifficulties` (
  `questionDifficultyId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(255) NOT NULL COMMENT 'name for the QuestionDifficulty',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionDifficultyId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='Difficulties as they apply to QuestionAssignments';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionDimensionAdaptiveRatings`
--

DROP TABLE IF EXISTS `QuestionDimensionAdaptiveRatings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionDimensionAdaptiveRatings` (
  `questionId` int unsigned NOT NULL COMMENT 'Question ID',
  `dimensionId` int unsigned NOT NULL COMMENT 'Dimension ID',
  `rating` int unsigned NOT NULL COMMENT 'Adaptive Rating',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionId`,`dimensionId`),
  KEY `dimensionId` (`dimensionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Ratings for questions in adaptive qbank';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionGradingCategories`
--

DROP TABLE IF EXISTS `QuestionGradingCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionGradingCategories` (
  `questionGradingCategoryId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-increment ID for the question grading categories',
  `name` varchar(255) DEFAULT NULL COMMENT 'name of the grading category',
  `description` varchar(255) DEFAULT NULL COMMENT 'description of the grading category',
  `isArchived` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Whether grading category is archived or not',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionGradingCategoryId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3 COMMENT='Storing the grading categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionGradingCategoryGroups`
--

DROP TABLE IF EXISTS `QuestionGradingCategoryGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionGradingCategoryGroups` (
  `questionGradingGroupId` int unsigned NOT NULL COMMENT 'question grading category group id',
  `questionGradingCategoryId` int unsigned NOT NULL COMMENT 'question grading category id',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionGradingGroupId`,`questionGradingCategoryId`),
  KEY `questionGradingCategoryId` (`questionGradingCategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A list of grading categories linked to gradingCategoryGroup.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionGradingGroups`
--

DROP TABLE IF EXISTS `QuestionGradingGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionGradingGroups` (
  `questionGradingGroupId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-increment ID for the question grading category groups',
  `name` varchar(255) DEFAULT NULL COMMENT 'name of the grading category group',
  `description` varchar(255) DEFAULT NULL COMMENT 'description of the grading category group',
  `isPublished` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Whether grading category group is published or not',
  `isArchived` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Whether grading category group is archived or not',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionGradingGroupId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COMMENT='Storing the grading category groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionGradingScores`
--

DROP TABLE IF EXISTS `QuestionGradingScores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionGradingScores` (
  `questionGradingScoreId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-increment ID for the question grading scores',
  `name` varchar(255) DEFAULT NULL COMMENT 'name of the grading score value',
  `description` text COMMENT 'description of the grading score value',
  `score` float DEFAULT NULL COMMENT 'grading score value',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionGradingScoreId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='Storing the grading scores for questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionMedia`
--

DROP TABLE IF EXISTS `QuestionMedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionMedia` (
  `questionId` int unsigned NOT NULL COMMENT 'The Question to which the Media applies',
  `mediaId` int unsigned NOT NULL COMMENT 'The Media to which the Question applies',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionId`,`mediaId`),
  KEY `FK_Media_mediaId` (`mediaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Join table linking Questions to Media';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionMetadatas`
--

DROP TABLE IF EXISTS `QuestionMetadatas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionMetadatas` (
  `questionId` int unsigned NOT NULL COMMENT 'questionId of the Question',
  `dimensionId` int unsigned NOT NULL COMMENT 'The dimension for which the metadata apply',
  `key` varchar(255) NOT NULL COMMENT 'key for the QuestionMetadata for the questionId',
  `value` varchar(255) NOT NULL COMMENT 'value of the QuestionMetadata for a questionId and key',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionId`,`dimensionId`,`key`,`value`),
  KEY `IX_questionId` (`questionId` DESC),
  KEY `IX_questionId_dimensionId` (`questionId`,`dimensionId`),
  KEY `IX_key_value` (`key`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Storing the question metadata while importing the content';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionOptions`
--

DROP TABLE IF EXISTS `QuestionOptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionOptions` (
  `questionOptionId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `questionId` int unsigned NOT NULL COMMENT 'Question in which the QuestionOption belongs',
  `optionText` text NOT NULL COMMENT 'text for the QuestionOption',
  `isCorrect` tinyint(1) NOT NULL COMMENT 'Is it correct to select this option?',
  `points` tinyint NOT NULL COMMENT 'points assigned to the QuestionOption',
  `explanation` text COMMENT 'expanation for the QuestionOption',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionOptionId`),
  KEY `FK_Questions_questionId` (`questionId`)
) ENGINE=InnoDB AUTO_INCREMENT=5884714 DEFAULT CHARSET=utf8mb3 COMMENT='Options or possible answers in a Question';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionReferences`
--

DROP TABLE IF EXISTS `QuestionReferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionReferences` (
  `questionId` int unsigned NOT NULL COMMENT 'Corresponding Question created from foreign system',
  `systemId` tinyint unsigned NOT NULL COMMENT 'foreign System from which the Question originated',
  `foreignId` varchar(255) NOT NULL COMMENT 'id value from the foreign System',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionId`,`systemId`,`foreignId`),
  KEY `systemId` (`systemId`),
  KEY `foreignId` (`foreignId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Lookup table for foreign id value and System by Question';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Questions`
--

DROP TABLE IF EXISTS `Questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Questions` (
  `questionId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `questionTypeId` tinyint unsigned NOT NULL COMMENT 'type of the Question',
  `questionText` text NOT NULL COMMENT 'text of the Question',
  `explanation` text COMMENT 'explanation for the Question',
  `pointsPossible` smallint unsigned NOT NULL COMMENT 'Number of possible points if all options answered correctly',
  `hash` char(32) NOT NULL COMMENT 'MD5 of the Question',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionId`),
  KEY `FK_QuestionTypes_questionTypeId` (`questionTypeId`),
  KEY `IX_hash` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=1741413 DEFAULT CHARSET=utf8mb3 COMMENT='Questions of many types that can have one or many options';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionSections`
--

DROP TABLE IF EXISTS `QuestionSections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionSections` (
  `questionSectionId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-increment ID for the question sections',
  `questionId` int unsigned NOT NULL COMMENT 'questionId of the Question',
  `issue` text COMMENT 'Issue of the section',
  `rules` text COMMENT 'Rules of the section',
  `analysis` text COMMENT 'Analysis of the section',
  `conclusion` text COMMENT 'Conclusion of the section',
  `weight` smallint unsigned NOT NULL COMMENT 'Weightage of a section in terms of percentage',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionSectionId`),
  KEY `IX_questionId` (`questionId`)
) ENGINE=InnoDB AUTO_INCREMENT=14999 DEFAULT CHARSET=utf8mb3 COMMENT='Storing the sections while importing the questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionTags`
--

DROP TABLE IF EXISTS `QuestionTags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionTags` (
  `questionId` int unsigned NOT NULL COMMENT 'questionId to which the tag applies',
  `dimensionId` int unsigned NOT NULL COMMENT 'The dimension for which the tags apply',
  `tag` varchar(100) NOT NULL COMMENT 'tag for the question',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`dimensionId`,`questionId`,`tag`),
  KEY `IX_nodeRootId_questionId` (`questionId`),
  KEY `IX_tag` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Key/value pair table for storing things about node';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionTaxonomy`
--

DROP TABLE IF EXISTS `QuestionTaxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionTaxonomy` (
  `questionId` int unsigned NOT NULL COMMENT 'Question ID',
  `taxonomyTypeId` tinyint unsigned NOT NULL COMMENT 'Taxonomy Type',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionId`),
  KEY `FK_taxonomyTypeId` (`taxonomyTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Question Taxonomy Types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionTypes`
--

DROP TABLE IF EXISTS `QuestionTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionTypes` (
  `questionTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(30) NOT NULL COMMENT 'token name for QuestionType for use by the app',
  `displayName` varchar(255) NOT NULL COMMENT 'display name to describe the QuestionType',
  `description` varchar(255) NOT NULL COMMENT 'description of the QuestionType',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionTypeId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COMMENT='Types of Questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QuestionUcms`
--

DROP TABLE IF EXISTS `QuestionUcms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QuestionUcms` (
  `questionId` int unsigned NOT NULL COMMENT 'The Question to which the UCMS ID applies',
  `ucmsId` bigint unsigned NOT NULL COMMENT 'The UCMS ID assigned to the Question',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`questionId`,`ucmsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Join table linking Questions to UCMS IDs';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RefreshTokens`
--

DROP TABLE IF EXISTS `RefreshTokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RefreshTokens` (
  `refreshTokenId` char(64) NOT NULL COMMENT 'unique hash to identify the Refresh Token',
  `personId` int unsigned DEFAULT NULL COMMENT 'personId logged in for the Session',
  `lifetime` int unsigned NOT NULL COMMENT 'lifetime of the Refresh Token in seconds',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`refreshTokenId`),
  KEY `FK_personId` (`personId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Refresh Token handling for the LMS';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RemotePersons`
--

DROP TABLE IF EXISTS `RemotePersons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RemotePersons` (
  `remotePersonId` varchar(255) NOT NULL COMMENT 'Unique identifer of a person from the Remote system',
  `portalCode` varchar(100) NOT NULL COMMENT 'Portal Code of a Remote System',
  `personId` int unsigned NOT NULL COMMENT 'Unique identifer from the LMS Person system',
  `type` varchar(5) NOT NULL COMMENT 'Identifies type of federation',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`remotePersonId`,`portalCode`,`personId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Holds Remote persons data for the LMS Person.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ScormStatistics`
--

DROP TABLE IF EXISTS `ScormStatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ScormStatistics` (
  `registrationId` varchar(50) NOT NULL COMMENT 'Scorm registration ID',
  `nodeId` int NOT NULL COMMENT 'nodeId to which the Scorm statistics apply to',
  `enrollmentDetailId` int NOT NULL COMMENT 'Id of enrollmentDetail',
  `dimensionId` int unsigned NOT NULL COMMENT 'Dimension for the node',
  `scorePercentage` tinyint DEFAULT NULL COMMENT 'Score of learner in percentage',
  `completedAt` timestamp NULL DEFAULT NULL COMMENT 'Time the scorm couse was completed',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`registrationId`),
  KEY `IX_scormId_nodeId` (`registrationId`,`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SecurityChallengeResponses`
--

DROP TABLE IF EXISTS `SecurityChallengeResponses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SecurityChallengeResponses` (
  `securityChallengeId` int unsigned NOT NULL COMMENT 'SecurityChallenge being attempted',
  `securityQuestionId` tinyint unsigned NOT NULL COMMENT 'SecurityQuestion for attempt',
  `attempt` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'The number of attempts for the same Security Challenge',
  `response` char(32) DEFAULT NULL COMMENT 'the hashed response to the SecurityQuestion, NULL = abandoned/expired',
  `isCorrect` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'is the response correct?',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `securityQuestionMetadata` varchar(255) DEFAULT NULL COMMENT 'it is a serialized array(3,4)',
  `correctAnswer` char(32) DEFAULT NULL COMMENT 'xy (as string no commas or no space)',
  PRIMARY KEY (`securityChallengeId`,`securityQuestionId`,`attempt`),
  KEY `FK_SecurityQuestions_securityQuestionId` (`securityQuestionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A SecurityQuestion for each attempt of a SecurityChallenge';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SecurityChallenges`
--

DROP TABLE IF EXISTS `SecurityChallenges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SecurityChallenges` (
  `securityChallengeId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetail that triggered the SecurityChallenge',
  `securityChallengeStatusId` tinyint unsigned DEFAULT NULL COMMENT 'status of the SecurityChallenge',
  `securityQuestionTypeId` tinyint NOT NULL COMMENT 'security question type id',
  `sourceUrl` varchar(255) NOT NULL COMMENT 'source URL that triggered the SecurityChallenge for redirect upon success',
  `ruleCode` varchar(255) NOT NULL COMMENT 'ruleCode that triggered the SecurityChallenge',
  `allowedAttempts` tinyint unsigned NOT NULL COMMENT 'the allowed number of attempts to pass the SecurityChallenge',
  `allowedSeconds` smallint unsigned NOT NULL COMMENT 'the time in seconds allowed to pass each attempt of the SecurityChallenge',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`securityChallengeId`),
  KEY `FK_EnrollmentDetails_enrollmentDetailId` (`enrollmentDetailId`),
  KEY `FK_SecurityChallengeStatuses_securityChallengeStatusId` (`securityChallengeStatusId`),
  KEY `IX_securityQuestionTypeId` (`securityQuestionTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=21556069 DEFAULT CHARSET=utf8mb3 COMMENT='EnrollmentDetail triggered challenges to SecurityQuestions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SecurityChallengeStatuses`
--

DROP TABLE IF EXISTS `SecurityChallengeStatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SecurityChallengeStatuses` (
  `securityChallengeStatusId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `securityChallengeStatus` varchar(30) NOT NULL COMMENT 'SecurityChallengeStatus label',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`securityChallengeStatusId`),
  UNIQUE KEY `UQ_securityChallengeStatus` (`securityChallengeStatus`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COMMENT='Possible statuses of SecurityChallenges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SecurityQuestions`
--

DROP TABLE IF EXISTS `SecurityQuestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SecurityQuestions` (
  `securityQuestionId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `question` varchar(255) NOT NULL COMMENT 'Question text displayed to the person',
  `securityQuestionTypeId` tinyint NOT NULL DEFAULT '1' COMMENT 'security question type id',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`securityQuestionId`),
  UNIQUE KEY `UQ_question` (`question`),
  KEY `IX_securityQuestionTypeId` (`securityQuestionTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3 COMMENT='Stores security questions to aid in Person identification.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SecurityQuestionTypes`
--

DROP TABLE IF EXISTS `SecurityQuestionTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SecurityQuestionTypes` (
  `securityQuestionTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(30) NOT NULL COMMENT 'token name for SecurityType for use by the app',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`securityQuestionTypeId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COMMENT='Defines the Security Question types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SessionClients`
--

DROP TABLE IF EXISTS `SessionClients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SessionClients` (
  `sessionClientId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Session Client ID',
  `name` varchar(100) NOT NULL COMMENT 'Session Client Name',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'PersonId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'PersonId of the account that last updated the record',
  PRIMARY KEY (`sessionClientId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='The list of possible clients for a session';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Sessions`
--

DROP TABLE IF EXISTS `Sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sessions` (
  `sessionId` char(32) NOT NULL COMMENT 'unique hash to identify the Session',
  `personId` int unsigned DEFAULT NULL COMMENT 'personId logged in for the Session',
  `domain` varchar(50) NOT NULL COMMENT 'The domain upon which the Session resides',
  `data` varchar(2500) NOT NULL COMMENT 'Serialized data stored for the Session',
  `sessionClientId` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'Session Client ID',
  `modified` int unsigned NOT NULL COMMENT 'Time Session was modified in seconds since epoch',
  `lifetime` int unsigned NOT NULL COMMENT 'lifetime of the Session in seconds',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  PRIMARY KEY (`sessionId`),
  KEY `FK_PersonAccounts_personId` (`personId`),
  KEY `IX_updatedAt` (`updatedAt`),
  KEY `FK_sessionClientId` (`sessionClientId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Session handling for the LMS';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SiteMessages`
--

DROP TABLE IF EXISTS `SiteMessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SiteMessages` (
  `siteMessageId` int unsigned NOT NULL AUTO_INCREMENT,
  `message` varchar(1000) DEFAULT NULL,
  `section` varchar(25) NOT NULL DEFAULT 'all',
  `startTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expirationTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`siteMessageId`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb3 COMMENT='LMS Site notification messages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `StudyPlanDaysOff`
--

DROP TABLE IF EXISTS `StudyPlanDaysOff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `StudyPlanDaysOff` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'Study Plan Enrollment Detail ID',
  `offDate` date NOT NULL COMMENT 'The Off Date',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`,`offDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Study plan days off';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `StudyPlanDurations`
--

DROP TABLE IF EXISTS `StudyPlanDurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `StudyPlanDurations` (
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'Study Plan Enrollment Detail ID',
  `startDate` date NOT NULL COMMENT 'Daily duration start date',
  `endDate` date DEFAULT NULL COMMENT 'Daily duration end date',
  `dailyDuration` smallint unsigned NOT NULL COMMENT 'Study plan daily duration in minutes',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the daily duration was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the daily duration was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`enrollmentDetailId`,`startDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Person - Study plan daily duration for program';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `StudyPlanFixedDays`
--

DROP TABLE IF EXISTS `StudyPlanFixedDays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `StudyPlanFixedDays` (
  `calendarFixedDaysGroupId` int unsigned NOT NULL COMMENT 'ID from CalendarFixedDaysGroups table',
  `activityId` int unsigned NOT NULL COMMENT 'Activity ID from Activities table',
  `date` date NOT NULL COMMENT 'The fixed date for the activity',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`calendarFixedDaysGroupId`,`activityId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Table that stores fixed dates for activities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Systems`
--

DROP TABLE IF EXISTS `Systems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Systems` (
  `systemId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(20) NOT NULL COMMENT 'name of the System; import source',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`systemId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COMMENT='Lookup table of import sources';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TaxonomyTypes`
--

DROP TABLE IF EXISTS `TaxonomyTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TaxonomyTypes` (
  `taxonomyTypeId` tinyint unsigned NOT NULL COMMENT 'Type ID',
  `name` varchar(50) NOT NULL COMMENT 'Type Name',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`taxonomyTypeId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Taxonomy Types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestAnswerBlanks`
--

DROP TABLE IF EXISTS `TestAnswerBlanks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestAnswerBlanks` (
  `testQuestionId` bigint unsigned NOT NULL COMMENT 'Test Question',
  `questionBlankId` int unsigned NOT NULL COMMENT 'Question blank',
  `answerText` varchar(255) NOT NULL COMMENT 'Answer text',
  `isCorrect` tinyint unsigned NOT NULL COMMENT 'Whether the answer text is correct',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testQuestionId`,`questionBlankId`),
  KEY `FK_TestQuestions_testQuestionId` (`testQuestionId`),
  KEY `FK_QuestionBlanks_questionBlankId` (`questionBlankId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='The submitted answers for the blanks of fill-in-the-blank questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestAnswerEssayContexts`
--

DROP TABLE IF EXISTS `TestAnswerEssayContexts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestAnswerEssayContexts` (
  `testAnswerEssayContextId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(50) NOT NULL COMMENT 'name of the TestAnswerEssayContext',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testAnswerEssayContextId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='Context of the text in a TestAnswerEssay record';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestAnswerEssayHighlights`
--

DROP TABLE IF EXISTS `TestAnswerEssayHighlights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestAnswerEssayHighlights` (
  `testId` int unsigned NOT NULL COMMENT 'testId of the test that highlight apply to',
  `testAnswerEssayId` int unsigned NOT NULL COMMENT 'testAnswerEssayId of the answer text highlight apply to',
  `highlightId` int unsigned NOT NULL COMMENT 'Highlight Id of Highlights table',
  KEY `testAnswerEssayId` (`testAnswerEssayId`),
  KEY `highlightId` (`highlightId`),
  KEY `IX_testId_testAnswerEssayId` (`testId`,`testAnswerEssayId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Mapping table of highlights with essay answers of test';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestAnswerEssayMedia`
--

DROP TABLE IF EXISTS `TestAnswerEssayMedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestAnswerEssayMedia` (
  `testAnswerEssayId` int unsigned NOT NULL COMMENT 'The TestAnswerEssay the uploaded media applies to',
  `mediaId` int unsigned NOT NULL COMMENT 'Media uploaded to the TestAnswerEssay',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testAnswerEssayId`,`mediaId`),
  KEY `FK_Media_mediaId` (`mediaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Join table linking TestAnswerEssays to Media';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestAnswerEssays`
--

DROP TABLE IF EXISTS `TestAnswerEssays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestAnswerEssays` (
  `testAnswerEssayId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `testQuestionId` bigint unsigned NOT NULL COMMENT 'TestQuestion the answer applies to',
  `testAnswerEssayContextId` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'context for contents of the answerText field',
  `answerText` text COMMENT 'text of answer, comment on uploaded media, or instructor response',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testAnswerEssayId`),
  UNIQUE KEY `UQ_testQuestionId_testAnswerEssayContextId` (`testQuestionId`,`testAnswerEssayContextId`),
  KEY `FK_TestAnswerEssayContexts_testAnswerEssayContextId` (`testAnswerEssayContextId`)
) ENGINE=InnoDB AUTO_INCREMENT=18976318 DEFAULT CHARSET=utf8mb3 COMMENT='Answers and responses to essay Questions in a Test';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestAnswers`
--

DROP TABLE IF EXISTS `TestAnswers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestAnswers` (
  `testQuestionId` bigint unsigned NOT NULL COMMENT 'TestQuestion for the recorded answer',
  `questionOptionId` int unsigned NOT NULL COMMENT 'QuestionOption of the answer chosen',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testQuestionId`,`questionOptionId`) USING BTREE,
  KEY `FK_QuestionOptions_questionOptionId` (`questionOptionId`) USING BTREE,
  KEY `Index 3` (`createdAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Recorded answer(s) to the Questions in an instance of a Test';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestAttributes`
--

DROP TABLE IF EXISTS `TestAttributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestAttributes` (
  `testId` int unsigned NOT NULL COMMENT 'testId to which the TestAttribute applies for the key',
  `key` varchar(100) NOT NULL COMMENT 'key for the TestAttribute for the testId',
  `value` varchar(255) NOT NULL COMMENT 'value of the TestAttribute for a testId and key',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testId`,`key`),
  KEY `updatedAt` (`updatedAt`),
  KEY `ix_TestAttributes_01` (`key`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Key/value pair table for storing things about tests';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestCreditHours`
--

DROP TABLE IF EXISTS `TestCreditHours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestCreditHours` (
  `testId` int unsigned NOT NULL COMMENT 'Test ID',
  `orgCode` varchar(10) NOT NULL COMMENT 'Credit hours group',
  `creditHours` smallint unsigned NOT NULL COMMENT 'Credit Hours',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned DEFAULT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned DEFAULT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testId`),
  KEY `IX_orgCode` (`orgCode`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Credit Hours Per Test';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestNodeStatistics`
--

DROP TABLE IF EXISTS `TestNodeStatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestNodeStatistics` (
  `nodeId` int unsigned NOT NULL COMMENT 'test node',
  `dimensionId` int unsigned NOT NULL COMMENT 'dimension to which the statistics apply',
  `answeredCount` int unsigned NOT NULL COMMENT 'number of questions answered in the node',
  `incorrectCount` int unsigned NOT NULL COMMENT 'number of questions answered incorrectly in the node',
  `secondsElapsed` int unsigned NOT NULL COMMENT 'time in seconds elapsed while students were answering questions for the given node',
  `points` int unsigned NOT NULL COMMENT 'points scored on the node',
  `pointsPossible` int unsigned NOT NULL COMMENT 'points possible for the node',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`nodeId`,`dimensionId`),
  KEY `FK_Dimensions_dimensionId` (`dimensionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Aggregate statistics for a given test node for all users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestProctorForms`
--

DROP TABLE IF EXISTS `TestProctorForms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestProctorForms` (
  `testId` int unsigned NOT NULL COMMENT 'The TestId associated with the proctor form',
  `proctorPersonId` int unsigned DEFAULT NULL COMMENT 'Proctor Person ID',
  `proctorRelationType` varchar(255) DEFAULT NULL COMMENT 'Proctor Relation Type',
  `proctorExamSiteId` tinyint unsigned DEFAULT NULL COMMENT 'Proctor Exam Site Id',
  `proctorIdentificationTypeId` tinyint unsigned DEFAULT NULL COMMENT 'The type of identification used during proctor validation.',
  `validatedAt` timestamp NULL DEFAULT NULL COMMENT 'The date that the proctor form was validated.',
  `pendingTestStatusId` int DEFAULT NULL COMMENT 'The status id of the test after post proctor validation.',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testId`),
  KEY `proctorExamSiteId` (`proctorExamSiteId`),
  KEY `proctorIdentificationTypeId` (`proctorIdentificationTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Forms for Proctored Test';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestProctorViolation`
--

DROP TABLE IF EXISTS `TestProctorViolation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestProctorViolation` (
  `testId` int unsigned NOT NULL COMMENT 'The Id of the Test',
  `proctorType` varchar(50) NOT NULL COMMENT 'Type of Proctoring',
  `violationReason` text COMMENT 'Reason for Violation',
  `proctorName` varchar(50) DEFAULT NULL COMMENT 'Name of the Proctor',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Store the violation reason reported by Proctor';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestQuestionActivityStates`
--

DROP TABLE IF EXISTS `TestQuestionActivityStates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestQuestionActivityStates` (
  `testQuestionId` bigint unsigned NOT NULL COMMENT 'ID from TestQuestions',
  `state` text NOT NULL COMMENT 'json encoded activity state',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testQuestionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Saved states for activity questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestQuestionCategoryScores`
--

DROP TABLE IF EXISTS `TestQuestionCategoryScores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestQuestionCategoryScores` (
  `testQuestionId` bigint unsigned NOT NULL COMMENT 'test question id',
  `questionGradingCategoryId` int unsigned NOT NULL COMMENT 'question grading category id',
  `questionGradingScoreId` int unsigned NOT NULL COMMENT 'question grading score id',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testQuestionId`,`questionGradingCategoryId`),
  KEY `IX_testQuestionId` (`testQuestionId`),
  KEY `FK_QuestionGradingCategories_questionGradingCategoryId` (`questionGradingCategoryId`),
  KEY `FK_QuestionGradingScores_questionGradingScoreId` (`questionGradingScoreId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestQuestionHighlights`
--

DROP TABLE IF EXISTS `TestQuestionHighlights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestQuestionHighlights` (
  `testId` int unsigned NOT NULL COMMENT 'testId of the test that highlight apply to',
  `questionId` int unsigned NOT NULL COMMENT 'questionId of the Question',
  `highlightId` int unsigned NOT NULL COMMENT 'Highlight Id of Highlights table',
  KEY `questionId` (`questionId`),
  KEY `highlightId` (`highlightId`),
  KEY `IX_testId_questionId` (`testId`,`questionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Mapping table of highlights with question of test';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestQuestionOptionStrikeThroughs`
--

DROP TABLE IF EXISTS `TestQuestionOptionStrikeThroughs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestQuestionOptionStrikeThroughs` (
  `testQuestionId` bigint unsigned NOT NULL COMMENT 'TestQuestion for the recorded answer',
  `questionOptionId` int unsigned NOT NULL COMMENT 'QuestionOption of the answer chosen',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testQuestionId`,`questionOptionId`),
  KEY `FK_QuestionOptions_questionOptionId` (`questionOptionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Recorded questionOption(s) to the Questions in an instance of a Test';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestQuestions`
--

DROP TABLE IF EXISTS `TestQuestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestQuestions` (
  `testQuestionId` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `testId` int unsigned NOT NULL COMMENT 'The Test in which the Questions appear',
  `parentQuestionId` int unsigned DEFAULT NULL COMMENT 'questionId of the QuestionSet if applicable',
  `questionId` int unsigned NOT NULL COMMENT 'The Question which appears in the Test',
  `nodeId` int unsigned NOT NULL COMMENT 'nodeId for the question',
  `questionAssignmentId` int unsigned NOT NULL COMMENT 'QuestionAssignment record that assigned the Question to the Test',
  `sortOrder` smallint unsigned NOT NULL COMMENT 'Order in which the Questions appear in the Test',
  `sortSeed` int unsigned NOT NULL COMMENT 'Seed to reproduce the random sorting of the QuestionOptions',
  `points` smallint unsigned DEFAULT NULL COMMENT 'points scored on the TestQuestion',
  `pointsPossible` smallint unsigned NOT NULL COMMENT 'Points possible for the Question',
  `secondsElapsed` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'seconds elapsed while the student was on the question',
  `isMarkedForReview` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is this question marked for review?',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testQuestionId`) USING BTREE,
  KEY `FK_Tests_testId` (`testId`) USING BTREE,
  KEY `FK_Questions_parentQuestionId` (`parentQuestionId`) USING BTREE,
  KEY `FK_Questions_questionId` (`questionId`) USING BTREE,
  KEY `FK_QuestionAssignments_questionAssignmentId` (`questionAssignmentId`) USING BTREE,
  KEY `FK_Nodes_nodeId` (`nodeId`) USING BTREE,
  KEY `Index 7` (`createdAt`)
) ENGINE=InnoDB AUTO_INCREMENT=4818598779 DEFAULT CHARSET=utf8mb3 COMMENT='The Questions in order that appear in a Test instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestQuestionSectionScores`
--

DROP TABLE IF EXISTS `TestQuestionSectionScores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestQuestionSectionScores` (
  `testQuestionId` bigint unsigned NOT NULL COMMENT 'test question id',
  `questionSectionId` int unsigned NOT NULL COMMENT 'question section id',
  `questionGradingScoreId` int unsigned NOT NULL COMMENT 'question grading score id',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testQuestionId`,`questionSectionId`),
  KEY `IX_testQuestionId` (`testQuestionId`),
  KEY `FK_Questionsections_questionSectionId` (`questionSectionId`),
  KEY `FK_QuestionGradingScores_questionGradingScoreId` (`questionGradingScoreId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Tests`
--

DROP TABLE IF EXISTS `Tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tests` (
  `testId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `enrollmentDetailId` int unsigned NOT NULL COMMENT 'EnrollmentDetail to which the Test applies',
  `nodeId` int unsigned DEFAULT NULL COMMENT 'Node source for the Test',
  `nodeClassificationId` tinyint unsigned NOT NULL COMMENT 'classification of the Node source for the Test',
  `testStatusId` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'TestStatus of the Test',
  `name` varchar(255) NOT NULL COMMENT 'name of the Test',
  `lastViewedTestPosition` smallint unsigned DEFAULT NULL COMMENT 'sortOrder of the TestQuestion the Person last viewed',
  `totalQuestions` int unsigned NOT NULL COMMENT 'Number of Questions in the Test',
  `totalPoints` int unsigned DEFAULT NULL COMMENT 'total points scored on the Test',
  `totalPointsPossible` int unsigned NOT NULL COMMENT 'Number of points possible in the Test',
  `totalSecondsElapsed` int unsigned NOT NULL DEFAULT '0' COMMENT 'Total time in seconds elapsed while the student was actively in the Test',
  `isInReview` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is the test in Review Mode?',
  `startedAt` timestamp NULL DEFAULT NULL COMMENT 'The time the Test was started',
  `endedAt` timestamp NULL DEFAULT NULL COMMENT 'The time the Test was ended',
  `gradedAt` timestamp NULL DEFAULT NULL COMMENT 'The time the test was graded',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testId`),
  KEY `FK_EnrollmentDetails_enrollmentDetailId` (`enrollmentDetailId`),
  KEY `FK_Nodes_nodeId` (`nodeId`),
  KEY `IX_startedAt` (`startedAt`),
  KEY `FK_TestStatuses_testStatusId` (`testStatusId`),
  KEY `FK_NodeClassifications_nodeClassificationId` (`nodeClassificationId`),
  KEY `updatedAt` (`updatedAt`)
) ENGINE=InnoDB AUTO_INCREMENT=321911344 DEFAULT CHARSET=utf8mb3 COMMENT='Instances of tests referencing EnrollmentDetail and source';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestSettings`
--

DROP TABLE IF EXISTS `TestSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestSettings` (
  `testId` int unsigned NOT NULL COMMENT 'Test ID',
  `settings` text NOT NULL COMMENT 'json encoded settings',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Test settings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestsOffline`
--

DROP TABLE IF EXISTS `TestsOffline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestsOffline` (
  `offlineTestId` varchar(30) NOT NULL COMMENT 'offline test id',
  `testId` int unsigned NOT NULL COMMENT 'online test id',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`offlineTestId`),
  UNIQUE KEY `UQ_testId` (`testId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores Tests created offline';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TestStatuses`
--

DROP TABLE IF EXISTS `TestStatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TestStatuses` (
  `testStatusId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `testStatus` varchar(45) NOT NULL COMMENT 'TestStatus label',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`testStatusId`),
  UNIQUE KEY `UQ_testStatus` (`testStatus`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 COMMENT='Possible statuses of Tests';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TourGroups`
--

DROP TABLE IF EXISTS `TourGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TourGroups` (
  `tourGroupId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tour Group ID',
  `name` varchar(100) NOT NULL COMMENT 'Tour Group Name',
  `isArchived` tinyint unsigned NOT NULL COMMENT 'Whether Tour Group is Archived',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`tourGroupId`),
  UNIQUE KEY `UQ_name` (`name`),
  KEY `IX_isArchived` (`isArchived`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb3 COMMENT='A TourGroup is a collection of Tours. TourGroups are linked to Tours through the TourGroupTours table.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TourGroupTours`
--

DROP TABLE IF EXISTS `TourGroupTours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TourGroupTours` (
  `tourGroupId` int unsigned NOT NULL COMMENT 'Tour Group ID',
  `tourId` int unsigned NOT NULL COMMENT 'Tour ID',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`tourGroupId`,`tourId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A list of Tours linked to TourGroups.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TourLegs`
--

DROP TABLE IF EXISTS `TourLegs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TourLegs` (
  `tourLegId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tour Leg ID',
  `tourLegTypeId` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'Tour Leg Type ID',
  `tourTargetId` int unsigned DEFAULT NULL COMMENT 'Target ID',
  `targetParam` int unsigned DEFAULT NULL COMMENT 'Target Parameter (e.g. offeringDetailId)',
  `content` varchar(500) DEFAULT NULL COMMENT 'Leg Content',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`tourLegId`),
  KEY `IX_tourTargetId` (`tourTargetId`),
  KEY `FK_tourLegTypeId` (`tourLegTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=537 DEFAULT CHARSET=utf8mb3 COMMENT='A TourLeg is a combination of a target element and a description. TourLegs are linked to Tours through the TourTourLegs table.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TourLegTypes`
--

DROP TABLE IF EXISTS `TourLegTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TourLegTypes` (
  `tourLegTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tour Leg Type ID',
  `name` varchar(100) NOT NULL COMMENT 'Tour Leg Type Name',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'PersonId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'PersonId of the account that last updated the record',
  PRIMARY KEY (`tourLegTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='Types of TourLegs';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Tours`
--

DROP TABLE IF EXISTS `Tours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tours` (
  `tourId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tour ID',
  `name` varchar(100) NOT NULL COMMENT 'Tour Name',
  `page` varchar(50) NOT NULL COMMENT 'Tour Page',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`tourId`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb3 COMMENT='A Tour is a collection of TourLegs set up for a specific page. Tours are linked to TourLegs through the TourTourLegs table.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TourTargets`
--

DROP TABLE IF EXISTS `TourTargets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TourTargets` (
  `tourTargetId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tour Target ID',
  `name` varchar(100) NOT NULL COMMENT 'Tour Target Name',
  `tourTargetTypeId` int NOT NULL COMMENT 'Target Type Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Tour Target Value',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'PersonId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'PersonId of the account that last updated the record',
  PRIMARY KEY (`tourTargetId`),
  KEY `IX_tourTargetTypeId` (`tourTargetTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb3 COMMENT='TourTargets are page elements that can be the target of a TourLeg.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TourTargetTypes`
--

DROP TABLE IF EXISTS `TourTargetTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TourTargetTypes` (
  `tourTargetTypeId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tour Target Type ID',
  `name` varchar(100) NOT NULL COMMENT 'Tour Target Type Name',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'PersonId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'PersonId of the account that last updated the record',
  PRIMARY KEY (`tourTargetTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COMMENT='Types of target elements in TourTargets.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TourTourLegs`
--

DROP TABLE IF EXISTS `TourTourLegs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TourTourLegs` (
  `tourId` int unsigned NOT NULL COMMENT 'Tour ID',
  `tourLegId` int unsigned NOT NULL COMMENT 'Tour Leg ID',
  `sortOrder` smallint unsigned NOT NULL COMMENT 'Leg Sort Order',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`tourId`,`tourLegId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='An ordered list of TourLegs linked to Tours.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TravNodes`
--

DROP TABLE IF EXISTS `TravNodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TravNodes` (
  `NodeId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Ucms`
--

DROP TABLE IF EXISTS `Ucms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ucms` (
  `ucmsId` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(1500) NOT NULL COMMENT 'Title',
  `productId` int NOT NULL DEFAULT '0' COMMENT 'BDS Product ID',
  `productGroup` varchar(50) NOT NULL COMMENT 'ProductGroup from BDS Product',
  `isArchived` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Whether ucms record is archived',
  `isEditable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 => editable true, 0 => false record is not editable',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  `ucmsContentGroupId` bigint unsigned DEFAULT NULL COMMENT 'Ucms Content Group ID',
  PRIMARY KEY (`ucmsId`),
  KEY `IX_productGroup` (`productGroup`),
  KEY `idx_ucms_ucmsId` (`ucmsId`),
  KEY `idx_ucms_productId` (`productId`),
  KEY `idx_ucms_isArchived_productId` (`isArchived`,`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=6755333399029164 DEFAULT CHARSET=utf8mb3 COMMENT='UCMS media records';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsAssignments`
--

DROP TABLE IF EXISTS `UcmsAssignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsAssignments` (
  `ucmsId` bigint unsigned NOT NULL COMMENT 'ucms that is assigned to Content',
  `contentId` int unsigned NOT NULL COMMENT 'Content that is assigned to ucmsPresentation',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`ucmsId`,`contentId`),
  KEY `FK_Contents_contentId` (`contentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Assigns a ucms57Presentation to Content';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsContentGroups`
--

DROP TABLE IF EXISTS `UcmsContentGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsContentGroups` (
  `ucmsContentGroupId` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing primary key',
  `name` varchar(255) NOT NULL COMMENT 'The name of the ucms content groups',
  `assetCount` int unsigned DEFAULT NULL COMMENT 'Asset count of the ucms content group',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`ucmsContentGroupId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6755258320552482 DEFAULT CHARSET=utf8mb3 COMMENT='Content Groups of Ucms Lite';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsHostAccounts`
--

DROP TABLE IF EXISTS `UcmsHostAccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsHostAccounts` (
  `ucmsHostAccountId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto incrementinng Primary Key',
  `ucmsHostTypeId` tinyint unsigned NOT NULL COMMENT 'Ucms Host type ID',
  `accountId` varchar(50) DEFAULT NULL COMMENT 'Account ID',
  `accountName` varchar(50) DEFAULT NULL COMMENT 'Account Name',
  `ucmsHostTypeAccountId` tinyint DEFAULT NULL COMMENT 'UCMS Hosttype Account ID',
  `clientId` varchar(100) DEFAULT NULL COMMENT 'Client ID',
  `clientSecret` varchar(250) DEFAULT NULL COMMENT 'Client Secret',
  `username` varchar(50) DEFAULT NULL COMMENT 'Account Username',
  `password` varchar(50) DEFAULT NULL COMMENT 'Account Password',
  `policyKey` varchar(250) DEFAULT NULL COMMENT 'Policy Key',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`ucmsHostAccountId`),
  UNIQUE KEY `UQ_ucmsHostTypeId_accountName` (`ucmsHostTypeId`,`accountName`),
  KEY `IX_accountId` (`accountId`),
  KEY `IX_accountName` (`accountName`),
  KEY `ucmsHostTypeId` (`ucmsHostTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=2792 DEFAULT CHARSET=utf8mb3 COMMENT='Ucms Host Accounts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsHosts`
--

DROP TABLE IF EXISTS `UcmsHosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsHosts` (
  `ucmsHostId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Host ID',
  `ucmsId` bigint unsigned NOT NULL COMMENT 'UCMS ID',
  `ucmsHostTypeId` tinyint unsigned NOT NULL COMMENT 'Host type ID',
  `isActive` tinyint unsigned NOT NULL COMMENT 'Whether host is active',
  `isEditable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 => editable true, 0 => false record is not editable',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`ucmsHostId`),
  KEY `IX_isEditable` (`isEditable`),
  KEY `UcmsHosts_ibfk_2` (`ucmsHostTypeId`),
  KEY `idx_ucmsHosts_ucmsId` (`ucmsId`),
  KEY `idx_ucmsHosts_ucmsHostId` (`ucmsHostId`),
  KEY `idx_ucmsHosts_isActive_hostTypeId` (`isActive`,`ucmsHostTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=587731 DEFAULT CHARSET=utf8mb3 COMMENT='UCMS media hosts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsHostSeminars`
--

DROP TABLE IF EXISTS `UcmsHostSeminars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsHostSeminars` (
  `ucmsHostId` int unsigned NOT NULL COMMENT 'Host ID',
  `ucmsHostTypeId` tinyint unsigned NOT NULL COMMENT 'Host type ID',
  `ucmsHostForeignId` bigint DEFAULT NULL COMMENT 'Host foreign ID',
  `startDate` timestamp NOT NULL COMMENT 'Start date',
  `durationMinutes` smallint NOT NULL COMMENT 'Duration in minutes',
  `ucmsHostAccountId` int unsigned NOT NULL COMMENT 'Ucms Host Account ID',
  `instructorId` int DEFAULT NULL COMMENT 'PersonID of the instructor for the seminar',
  `groupName` varchar(50) DEFAULT NULL COMMENT 'Name of the group',
  `ucmsRoomTypeId` int DEFAULT NULL COMMENT 'UCMS Room Type Id',
  `ucmsHostSeminarSubTypeId` tinyint DEFAULT NULL COMMENT 'UCMS Host Seminar Subtype ID',
  `roomVerified` tinyint DEFAULT '0' COMMENT 'Room is Verified',
  `ucmsHostAlternateForeignId` varchar(255) DEFAULT NULL COMMENT 'Alternate UCMS Host Foreign ID',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`ucmsHostId`),
  KEY `FK_UcmsHostSeminars_ucmsHostTypeId` (`ucmsHostTypeId`),
  KEY `FK_ucmsHostAccountId` (`ucmsHostAccountId`),
  KEY `idx_ucmsHostSeminars_ucmsHostId` (`ucmsHostId`),
  KEY `idx_ucmsHostSeminars_startDate` (`startDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='UCMS Live Seminar Hosts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsHostSeminarSubTypes`
--

DROP TABLE IF EXISTS `UcmsHostSeminarSubTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsHostSeminarSubTypes` (
  `ucmsHostSeminarSubTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'UCMS Host Seminar Subtype ID',
  `name` varchar(50) NOT NULL COMMENT 'UCMS Seminar Subtype name',
  `ucmsHostTypeId` tinyint unsigned NOT NULL COMMENT 'Ucms Host type ID',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`ucmsHostSeminarSubTypeId`),
  KEY `FK_ucmsHostTypeId` (`ucmsHostTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='UCMS Seminar Subtypes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsHostTypeAccounts`
--

DROP TABLE IF EXISTS `UcmsHostTypeAccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsHostTypeAccounts` (
  `ucmsHostTypeAccountId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'UCMS Host type Account ID',
  `ucmsHostTypeId` tinyint unsigned NOT NULL COMMENT 'Ucms Host type ID',
  `name` varchar(50) NOT NULL COMMENT 'Name of the account type',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`ucmsHostTypeAccountId`),
  KEY `FK_ucmsHostTypeId` (`ucmsHostTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='Stores the types of accounts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsHostTypes`
--

DROP TABLE IF EXISTS `UcmsHostTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsHostTypes` (
  `ucmsHostTypeId` tinyint unsigned NOT NULL COMMENT 'Host type ID',
  `name` varchar(50) NOT NULL COMMENT 'Host type name',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`ucmsHostTypeId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='UCMS media host types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsHostVideos`
--

DROP TABLE IF EXISTS `UcmsHostVideos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsHostVideos` (
  `ucmsHostId` int unsigned NOT NULL COMMENT 'Host ID',
  `ucmsHostTypeId` tinyint unsigned NOT NULL COMMENT 'Host type ID',
  `ucmsHostForeignId` bigint DEFAULT NULL COMMENT 'Host foreign ID',
  `cuePoints` varchar(255) DEFAULT NULL COMMENT 'Cue points',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`ucmsHostId`),
  KEY `FK_UcmsHostVideos_ucmsHostTypeId` (`ucmsHostTypeId`),
  KEY `idx_ucmsHostVideos_ucmsHostId` (`ucmsHostId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='UCMS Video hosts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsPollQuestions`
--

DROP TABLE IF EXISTS `UcmsPollQuestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsPollQuestions` (
  `ucmsPollQuestionId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'the poll question id',
  `ucmsPollId` int unsigned NOT NULL COMMENT 'the poll id',
  `securityQuestionId` tinyint unsigned NOT NULL COMMENT 'security question Id',
  `displayAt` timestamp NOT NULL COMMENT 'the time at which the question should be displayed to the user',
  `isAnswered` tinyint unsigned DEFAULT NULL COMMENT 'Is the question answered or not',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`ucmsPollQuestionId`),
  KEY `FK_ucmsPollId` (`ucmsPollId`),
  KEY `FK_securityQuestionId` (`securityQuestionId`)
) ENGINE=InnoDB AUTO_INCREMENT=252008 DEFAULT CHARSET=utf8mb3 COMMENT='Polling questions related to the Polls';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsPolls`
--

DROP TABLE IF EXISTS `UcmsPolls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsPolls` (
  `ucmsPollId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'the poll id',
  `ucmsId` bigint unsigned NOT NULL COMMENT 'UCMS Id',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`ucmsPollId`)
) ENGINE=InnoDB AUTO_INCREMENT=62230 DEFAULT CHARSET=utf8mb3 COMMENT='Polls to track student presence in a seminar';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsPollVisibility`
--

DROP TABLE IF EXISTS `UcmsPollVisibility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsPollVisibility` (
  `ucmsPollQuestionId` int unsigned NOT NULL COMMENT 'The poll question id',
  `isPollVisible` tinyint unsigned DEFAULT NULL COMMENT 'Is the poll question visible',
  `visibleAt` varchar(255) DEFAULT NULL COMMENT 'When was the poll question visible',
  `mouseMoved` tinyint unsigned DEFAULT NULL COMMENT 'Is there any mouse movement',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`ucmsPollQuestionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Tracking data related to polling question visibility';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsProductHostMappings`
--

DROP TABLE IF EXISTS `UcmsProductHostMappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsProductHostMappings` (
  `ucmsProductHostMappingId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing primary key',
  `productGroup` varchar(50) NOT NULL COMMENT 'The name of the product group',
  `productLevel` varchar(20) NOT NULL,
  `orgCodes` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL COMMENT 'The name of the mapping',
  `ucmsHostTypeId` tinyint NOT NULL COMMENT 'Id of ucms host type',
  `ucmsHostAccountId` int unsigned NOT NULL COMMENT 'Ucms Host Account ID',
  `ucmsHostSeminarSubTypeId` tinyint DEFAULT NULL COMMENT 'UCMS Host Seminar Subtype ID',
  `ucmsHostTypeAccountId` tinyint DEFAULT NULL COMMENT 'UCMS Hosttype Account ID',
  PRIMARY KEY (`ucmsProductHostMappingId`),
  UNIQUE KEY `UQ_productGroup_productLevel_orgCodes` (`productGroup`,`productLevel`,`orgCodes`),
  KEY `IX_productGroup_productLevel` (`productGroup`,`productLevel`)
) ENGINE=InnoDB AUTO_INCREMENT=339 DEFAULT CHARSET=utf8mb3 COMMENT='UCMS Product Host Mapping';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsRoomTypes`
--

DROP TABLE IF EXISTS `UcmsRoomTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsRoomTypes` (
  `ucmsRoomTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'UCMS Room type ID',
  `name` varchar(50) NOT NULL COMMENT 'UCMS Room type name',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`ucmsRoomTypeId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='UCMS Room types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsStatistics`
--

DROP TABLE IF EXISTS `UcmsStatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsStatistics` (
  `ucmsId` bigint NOT NULL COMMENT 'The UCMS ID that the statistics apply to',
  `enrollmentDetailId` int NOT NULL COMMENT 'EnrollmentDetail that the UCMS statistics apply to',
  `currentPosition` smallint unsigned DEFAULT NULL COMMENT 'The current position',
  `maxPosition` smallint unsigned DEFAULT NULL COMMENT 'The max position',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'PersonId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'PersonId of the account that last updated the record',
  PRIMARY KEY (`ucmsId`,`enrollmentDetailId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores current and max positions for a media asset and enrollment detail';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UcmsTypes`
--

DROP TABLE IF EXISTS `UcmsTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UcmsTypes` (
  `ucmsTypeId` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `name` varchar(255) NOT NULL COMMENT 'The name of the NodeRootType',
  `description` varchar(255) NOT NULL COMMENT 'The description of the NodeRootType',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`ucmsTypeId`),
  UNIQUE KEY `UQ_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='Types of Ucms';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UserAgents`
--

DROP TABLE IF EXISTS `UserAgents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserAgents` (
  `userAgentId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key',
  `userAgent` varchar(255) NOT NULL COMMENT 'user agent string',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  PRIMARY KEY (`userAgentId`),
  UNIQUE KEY `UQ_userAgent` (`userAgent`)
) ENGINE=InnoDB AUTO_INCREMENT=90032 DEFAULT CHARSET=utf8mb3 COMMENT='Stores unique user agents';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `VideoChannels`
--

DROP TABLE IF EXISTS `VideoChannels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `VideoChannels` (
  `videoChannelId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Video Channel ID',
  `name` varchar(100) NOT NULL COMMENT 'Video Channel Name',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'time the record was created',
  `createdBy` int unsigned NOT NULL COMMENT 'personId of the account that created the record',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'time the record was last updated',
  `updatedBy` int unsigned NOT NULL COMMENT 'personId of the account that last updated the record',
  PRIMARY KEY (`videoChannelId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='Video Channels for Categorizing Enrollment Detail Videos';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-26 19:58:41
