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
      ]
  }
}

```