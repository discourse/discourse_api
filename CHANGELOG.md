# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [0.40.0] - 2020-05-07
### Fixed
- Add missing attributes to `sync_sso`

### Added
- Add delete category method

## [0.39.3] - 2020-04-30
### Fixed
- Add `reviewable_by_group_name` to categories

## [0.39.2] - 2020-04-30
### Fixed
- Add `members_visibility_level` to group

## [0.39.1] - 2020-03-27
### Fixed
- Ensure released gem version matches this commit

## [0.39.0] - 2020-03-27
### Added
- Get latest posts across topics via posts.json
- Allow  more options parameters when creating a category
- Don't require topic slug when updating topic status
- Example files now read config.yml file when present for client settings

### Fixed
- Issue with `topic_posts` and frozen strings
- Fixed some topic and category methods

## [0.38.0] - 2019-10-18
### Added
- Allow setting locale in SingleSignOn
- Optional param to group memebrs to include owners as well as members

## [0.37.0] - 2019-09-23
### Added
- user-badges endpoint for full badges list
- expanded list of allowed messages
- grant/revoke moderation

## [0.36.0] - 2019-07-18
### Added
- Added poll methods
### Fixed
- Updated create topic example
- Fixed capialization for header auth keys

## [0.35.0] - 2019-05-15
### Added
- Added `custom_fields` param to create/update category
- Added `frozen_string_literal: true` to all the files
- Added rubocop and all the changes that went along with it
### Fixed
- Allow `api_username` to be changed for an initialized client
- Update many of the `/users` routes to use the `/u` route
### Changed
- Changed `update_trust_level` to follow consistent method param syntax where
  you specify the id first followed by params

## [0.34.0] - 2019-04-02
### Added
- Header based authentication
### Removed
- Query param based authentication

## [0.33.0] - 2019-03-04
### Added
- Added a new method to update a users notification level in a category

## [0.32.0] - 2019-02-13
### Added
- Added a new method to update a users notification level in a group

## [0.31.0] - 2019-02-07
### Added
- Added `deactivate` method
- Added 201 and 204 as valid POST responses

## [0.30.0] - 2018-12-19
### Added
- Add params hash to `list_users`

## [0.29.0] - 2018-12-07
### Added
- Add `add_groups` and `remove_groups` to `sync_sso`

## [0.28.2] - 2018-11-26
### Fixed
- Updated arguments for suspending a user

## [0.28.1] - 2018-10-26
### Fixed
- Fixed non-URI chars in `check_username` method

## [0.28.0] - 2018-10-23
### Added
- Added `check_username` method

## [0.27.0] - 2018-09-14
### Added
- Added `site_settings_update` method

## [0.26.0] - 2018-09-10
### Added
- Added user `user_actions` endpoint so you can retrieve `user_replies` and
  `user_topics_and_replies`

## [0.25.0] - 2018-08-15
### Added
- Added ability to rescue certain error classes and inspect the response object

## [0.24.0] - 2018-05-30
### Added
- Added support for custom `user_fields` when creating a user

## [0.23.1] - 2018-05-24
### Fixed
- Can now change `api_username` without creating a new client

## [0.23.0] - 2018-05-24
### Added
- Added `delete_user` method

## [0.22.0] - 2018-05-04
### Added
- Support for subfolder paths

## [0.21.0] - 2018-04-23
### Fixed
- Update GET groups api route
- Update PUT groups api route

## [0.20.0] - 2017-12-13
### Added
- Add base error class
### Fixed
- Update SSO

## [0.19.0] - 2017-11-22
### Added
- Added optional `create_post` params

## [0.18.0] - 2017-10-17
### Added
- Added `update_group` API call
### Fixed
- Fixed params for create groups endpoint
- Fixed invite token API endpoint

## [0.17.0] - 2017-06-29
### Added
- Add title to SSO sync

## [0.16.1] - 2017-06-23
### Fixed
- `user_sso` should use `user_id` instead of `username`
- `upload_file` should also include optional `user_id` param

## [0.16.0] - 2017-05-14
### Added
- added `upload_file`
### Removed
- removed `upload_post_image`

## [0.15.0] - 2017-04-12
### Added
- added the ability to create private messages

## [0.14.1] - 2016-12-20
### Fixed
- allow for rack 2.0+ versions so that it doesn't clash with rails.

## [0.14.0] - 2016-10-30
### Added
- improved error responses by adding `NotFoundError`, `UnprocessableEntity`, and `TooManyRequests`
- added `delete_post` method

## [0.13.0] - 2016-10-09
### Added
- added `update_category`
- added `upload_post_image`

## [0.12.0] - 2016-10-06
### Added
- add endpoint for `/admin/users/{id}/suspend`
- add endpoint for `/admin/users/{id}/unsuspend`

## [0.11.0] - 2016-09-03
### Fixed
- add destination folder to backup download
- `post_action_users`

### Added
- `change_topic_status`
- set username of topic on creation

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





