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

## Floating Thoughts
- Ran into an issue early on with pushing onto the remote branch. Because rails creates a .git upon creation, the submodule wasn't able to add origin as a remote and I couldn't manually add it due to CodeSubmit hiding certain repo information.
- How large is this company? I'd expect for each employee to have numerous requests, so the queries should avoid N+1 queries and filter out as much data as possible via eager loading.
- Mathematically the date overlapping didn't seem bad. But to retrieve this data via SQL was definitely a stretch. I've never used `tsrange` and had to look up the documentation. Not 100% properly utilized but I get a better understanding of how ranges work in SQL.
- I chose to let the manager be able to see specific worker's details instead of showing an entire list of their workers. I think it wouldn't be useful for a manager to browse their entire roster when they have the API endpoint of seeing all overlapping requests. I think the manager can get much more useful information by nitpicking specific teammembers as opposed to fetching an entire list.
  - I do think that there can be a LOT of stretch-goal flexibility, such as fetching workers based on oldest vacation requests which are still `"pending"`, or be able to divide the list based on parameters
- If I had time, I would prefer to use an `Enum` system for the column `status` to help with validity. To me it's easier to validate integers as opposed to `Strings`
- I would want to implement more callbacks if granted more time.
  - When Manager processes an approval for an individual request, a callback action could be deducting hours from the worker's `vacation_days_remaining` column
  - When a Worker creates a request, a callback action could be deducting `requests_remaining` from a worker by 1 if it was a valid request.

## Struggles/Pain Points
- I feel within the 4 hours I couldn't really customize the best solution for a typical manager/worker. I tried my best to create solutions a worker would be satisfied with, and was thinking mostly of what a manager would need to see from requests/what isn't necessary. I think I spent over a fair amount of time on these ideas. Definitely learned from this bottleneck of time.
- Code quality lowered as time came closer to due date. I was utilizing the Facade system(Facade, PORO) in order to subjugate/localize errors. It worked well but as I pivoted back in a few times of the project, I realized using the Facade system will call for more areas to fix code as well.
- Finding the correct format to match the JSON contract as per `README` and calling the formatter everywhere based on Rails default datetime format was tough, and I realized how ambiguous datetime can really be! This slowed down making tests and finding the correct assertions.
- Datetime operations with Datetime as ranges. I feel comfortable with operating with Datetimes, but not as ranges. I feel pretty eager to learn more about ranges because I can see how their use cases are extremely relevant to companies.