## Problem: Vacation requests must be automated while ensuring enough employees are available to work

## Solution: Create TWO API's, one for worker, one for manager
- First API will handle workers' requests
- Send requests through query string due to time constraint
  - Allows me to assert my tests without having to format JSON body to send through Postman
- Workers can: 
  - See their own requests(and filter them by status)
  - See their number of remaining vacation days
  - Make new requests if they haven't been exhausted. Limit = 30/yr

- Managers can:
  - See ALL requests(and filter by status)
  - See overview for each specific employee
  - See overview of ALL overlapping requests
  - Act on a specific request and approve/reject

## Workers API
- Routes:
  - GET, /workers/:id/requests?filter=status
    - Will get all requests for a SPECIFIC worker. DEFAULT filter is ALL ASC by created by
  - GET, /workers/:id/vacation_days
    - Will get remaining vacation days, return as hours rounded FLOOR
  - POST, /workers/:id/requests
    - Will create a new Vacation Request IF worker has requests available

## Managers API
- Routes:
  - GET, /managers/requests?filter=status
    - Will get ALL requests. DEFAULT filter is PENDING
  - GET, /managers/employee/:worker_id
    - Will get information of specific employee
  - GET, /managers/requests/overlapping
    - Will get ALL requests which are overlapping
  - GET, /managers/:manager_id/requests/:id
    - Will get a specific request and can choose to approve/deny it here
    - Approve/Deny button that leads to
      - PATCH, /managers/:manager_id/requests/:id

## Database
- PSQL as a Relational DB
  - Data is defined as structured roles and don't need the flexibility/variant inputs of a Non-Relational
  - Numerous queries look only into its own table, and relationships of Manager - Worker, Worker - Vacation_Requests
    - Relationships are solidified with foriegn keys
  - Helps with filtering a specific table's column(filter by status)
## Models
- Worker:
  - id
  - manager_id
  - vacation_time_remaining(default 1000), minutes
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