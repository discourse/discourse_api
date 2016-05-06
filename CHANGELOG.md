# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/). 

## [0.10.1] - 2016-05-04
### Fixed
- raise an error if search is empty
- fix /category path to be just /c
- return errors for category_latest_topics if there are some

## [0.10.0] - 2016-04-19
### Added
- group_members: Allows you to retrieve more than 100 users with pagination (offset &
  limit)
### Fixed
- Deprication warning with SimpleCov
- updated rack dependency and added ruby 2.3 to travis config

## [0.9.1] - 2016-03-23
### Fixed
- topic and post like/flag need to use `:id`

## [0.9.0] - 2016-03-22
### Added
- can now like/flag topics and posts

## [0.8.1] - 2016-03-03
### Fixed
- enable use of discourse_api to make unauthenticated requests to discourse
  endpoints like /categories and /topics 

## [0.8.0] - 2016-02-28
### Added
- get stats from admin dashboard
- get only stat totals from admin dashboard

## [0.7.0] - 2015-12-09
### Added
- get user by external_id

## [0.6.2] - 2015-12-02
### Fixed
- `API::Params` will not work correctly when both optional and defaults are
  specified

## [0.6.1] - 2015-11-28
### Fixed
- typo in topic_posts method

## [0.6.0] - 2015-11-27
### Added
- get posts in topic by an array of id's

## [0.5.1] - 2015-11-21
### Fixed
- remove puts statement

## [0.5.0] - 2015-11-21
### Added
- get latest category topics by page

## [0.4.0] - 2015-01-15
### Added
- generate an api key for a user
- revoke an api key for a user
- update user trust level
- grant user badge

## [0.3.6] - 2015-01-11
### Added
- list badges
- view email settings
- list emails sent
- list badges by user
- be able to specify SSL connection settings
- list api keys generated
- list backups created

## [0.3.5] - 2015-01-06
### Added
- Can now get a list of users by type: active, new, staff, etc.
- `client.category_latest_posts("category-slug")` endpoint

## [0.1.2] - 2014-05-11

- Release





