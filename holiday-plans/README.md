# Holiday Plans

## Description

Holiday Plans is a project created to help both managers and employees with requesting and approving/denying vacation requests. For workers, Holiday Plans will expose informations such as:
  - Their own vacation requests
    - Filtering is possible via `status`
  - Their number of remaining vacation days
  - Send a receipt of a vacation request they just created.

For managers, informations of the like will be exposed:
  - All of their worker's vacation requests
    - Can be filtered similarly to a worker's request via `status`
  - An overview of specific employees
  - All overlapping vacation requests based on a specific vacation request
  - A receipt on if they successfully approved/rejected a vacation request.

This repository houses a back-end Rails API app.

## Local Setup

To use this project in your local environment, please follow the instructions:

  1. Clone the repository: `insert repository here`
  2. `cd holiday-plans`
  3. Install gem packages `bundler`. `bundle install` won't work due to Bundler version.
  4. Create the database `rails db:{create,migrate}`
  5. Launch a local server `rails s`
  6. `PORT 3000` is being used, so send any requests to `http://localhost:3000/api/v1/`.
  7. To run tests and make sure everything is functioning as planned, please run `rspec` OR `bundle exec rspec`

Take note of Rails and Ruby version. `ruby '2.5.3'` and `rails 5.2.4.5`. If there are any issues, please change your environment to match these Ruby/Rails versions. If running any Bundler based commands is problematic, please change versions to `bundler 2.1.4`.

## Learnings + Struggles

### Learnings
- In Rails, rendering a `204` status will omit any body or content to be exposed for whoever is exposing the endpoint. I figured a `204` with no body was a suggested practice, and my intuition is that Rails dictates a `No Content` response based on the value given.
  - Found the documentation of what was causing this. https://api.rubyonrails.org/classes/ActionController/Head.html#method-i-head with the arg `:no_content` or `204`
- I learned briefly about the concepts of `tsrange` and `ranges` in general. It hasn't been a deep dive yet, but I feel this will lead to optimal queries to find overlapping dates or even dates that don't mingle with each other(exclusive)
  - Documentation of `ranges` https://www.postgresql.org/docs/current/rangetypes.html
- There may be more than just skipping a `git init` action when it comes to creating a new Rails app. While the parent directory has a `.git` folder, the child will have conflicts if it has a separate `.git`. One way I solved this was using https://git-scm.com/docs/git-rm and using the flag `git rm --cached {subdirectory}`, and adding the child directory manually.
  - I tried to avoid the automatic `.git` generation by running the command `rails new {app_name} -G` to skip the git creation. Still ran into errors.


### Struggles
- I feel within the 4 hours I couldn't really customize the best solution for a typical manager/worker. I tried my best to create solutions a worker would be satisfied with, and was thinking mostly of what a manager would need to see from requests/what isn't necessary. I think I spent over a fair amount of time on these ideas. Definitely learned from this bottleneck of time.
- Code quality lowered as time came closer to due date. I was utilizing the Facade system(Facade, PORO) in order to subjugate/localize errors. It worked well but as I pivoted back in a few times of the project, I realized using the Facade system will call for more areas to fix code as well.
- Finding the correct format to match the JSON contract as per `README` and calling the formatter everywhere based on Rails default datetime format was tough, and I realized how ambiguous datetime can really be! This slowed down making tests and finding the correct assertions.
- Overcomplicating the Datetime overlap endpoint. After submission of this project, I quickly realized that making multiple `where` clauses can solve the problem, and this would have been optimal for my time. I do feel `tsrange` and `ranges` can lead to the solution, but with a limited amount of time I don't think I could masterfully deliver those new concepts.

## Database Models

- Worker:
  - id
  - manager_id
  - vacation_days_remaining(default 28), days
  - requests_remaining(default 30)
  - timestamp
  - Has Many Vacation Requests
  - Belongs To Manager

- Vacation Requests:
  - id
  - requested_start(date)
  - requested_end(date)
  - status(string)
  - timestamp
  - worker_id
  - Belongs To Worker

- Manager:
  - id
  - timestamp

## API Contract

`Vacation Request JSON Data`
```json
{
  "data": {
    "id": 1, // vacation_request_id
    "type": "vacation_request",
    "attributes": {
      "author": 3, //worker_id,
      "status": "pending",
      "resolved_by": 5, //manager_id Can be null if pending
      "request_created_at": "2020-08-09T12:57:13.506Z", // UTC ISO 8601 format for all dates
      "vacation_start_date": "2020-08-24T00:00:00.000Z",
      "vacation_end_date": "2020-09-04T00:00:00.000Z"
    }
  }
}
```

## Worker Based Requests

### Get All Worker's Vacation Requests

Optional filter by `status`, default set to ALL vacation requests.

Statuses include: `pending`, `approved`, `rejected`.

`GET /api/v1/workers/:id/requests`

OR

`GET /api/v1/workers/:id/requests?status=approved`
```json
{
  "data": {
    "id": null,
    "type": "worker_requests",
    "attributes": {
      "requests": [ //array of requests
        {
          "id": 1,
          "author": 3,
          "status": "pending",
          "resolved_by": null,
          "request_created_at": "2020-08-09T12:57:13.506Z",
          "vacation_start_date": "2020-08-24T00:00:00.000Z",
          "vacation_end_date": "2020-09-04T00:00:00.000Z"
        },
        {
          "id": 2,
          "author": 3,
          "status": "approved",
          "resolved_by": 5,
          "request_created_at": "2020-08-09T12:57:13.506Z",
          "vacation_start_date": "2020-08-24T00:00:00.000Z",
          "vacation_end_date": "2020-09-04T00:00:00.000Z"
        },
        {
          "id": 3,
          "author": 3,
          "status": "rejected",
          "resolved_by": 5,
          "request_created_at": "2020-08-09T12:57:13.506Z",
          "vacation_start_date": "2020-08-24T00:00:00.000Z",
          "vacation_end_date": "2020-09-04T00:00:00.000Z"
        }
      ]
    }
  }
}
```

### Check Worker's Remaining Vacation Days

`GET /api/v1/workers/:id/vacation_days`
```json
{
  "data": {
    "id": null,
    "type": "remaining_vacation_days",
    "attributes":{
      "remaining_days": 25
    }
  }
}
```

### Create New Worker's Vacation Request

`POST /api/v1/workers/:id/requests`

`Successful Vacation Request Creation:`
```json
{
  "data": {
    "id": 1,
    "type": "vacation_request",
    "attributes": {
      "author": 3,
      "status": "pending",
      "resolved_by": null,
      "request_created_at": "2020-08-09T12:57:13.506Z",
      "vacation_start_date": "2020-08-24T00:00:00.000Z",
      "vacation_end_date": "2020-09-04T00:00:00.000Z"
    }
  }
}
```

`Unsuccessful Vacation Request Creation:`
```json
{
  "data": {
    "error": "Please check start and end date to see if they're valid."
  }
}
```

## Manager Based Requests

### See All Vacation Requests

Manager can see their worker's requests. Decision made to limit worker requests shown based on manager's request due to `Overlapping Vacation` Requests request existing.

Optional filter by `status`, default set to ALL vacation requests.

Statuses include: `pending`, `approved`.

`GET /api/v1/managers/:id/vacation_requests`

OR

`GET /api/v1/managers/:id/vacation_requests?status=pending`

```json
{
  "data":{
    "id": null,
    "type": "vacation_requests",
    "attributes": {
      "vacation_requests": [
        {
          "id": 1,
          "author": 3,
          "status": "pending",
          "resolved_by": null,
          "request_created_at": "2020-08-09T12:57:13.506Z",
          "vacation_start_date": "2020-08-24T00:00:00.000Z",
          "vacation_end_date": "2020-09-04T00:00:00.000Z"
        },
        {
          "id": 2,
          "author": 3,
          "status": "approved",
          "resolved_by": 5,
          "request_created_at": "2020-08-09T12:57:13.506Z",
          "vacation_start_date": "2020-08-24T00:00:00.000Z",
          "vacation_end_date": "2020-09-04T00:00:00.000Z"
        }
      ]
  }
}
```

### See A Worker's Details

Manager can see a worker's attributes

`GET /api/v1/managers/worker_details/:worker_id`

```json
{
  "data":{
    "id": 1,
    "type": "worker_overview",
    "attributes": {
        "vacation_days_remaining": 28,
        "requests_remaining": 30,
        "hired_at": "2020-08-09T12:57:13.506Z"
    }
  }
}
```

### See All Overlapping Vacation Requests Based On Specific Vacation Request

Manager will input a specific worker's vacation request ID to see all vacation requests overlapping it

`GET /api/v1/managers/overlapping_requests/:vacation_request_id`

```json
{
  "data": {
    "id": null,
    "type": "overlapping_requests",
    "attributes": {
      "overlaps": [
        {
          "id": 1,
          "author": 3,
          "status": "pending",
          "resolved_by": null,
          "request_created_at": "2020-08-09T12:57:13.506Z",
          "vacation_start_date": "2020-08-24T00:00:00.000Z",
          "vacation_end_date": "2020-09-04T00:00:00.000Z"
        },
        {
          "id": 2,
          "author": 3,
          "status": "approved",
          "resolved_by": 5,
          "request_created_at": "2020-08-09T12:57:13.506Z",
          "vacation_start_date": "2020-08-25T00:00:00.000Z",
          "vacation_end_date": "2020-09-04T00:00:00.000Z"
        }
      ]
    }
  }
}
```

### Update Worker's Vacation Request

Manager can choose a status to update the vacation request's status and stamp `resolved_by` with their ID.

`GET /api/v1/managers/:manager_id/requests/:vacation_request_id?status=approved`

```json
{
    "message": "Status updated to \"approved\""
}
```