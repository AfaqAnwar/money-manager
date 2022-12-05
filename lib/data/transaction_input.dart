// Transaction Input Form Data
Map<String, dynamic> inputFormData = {
  "status": 1,
  "data": [
    {
      "questions": [
        {
          "question_id": "0",
          "fields": ["Income", "Expense"],
          "_id": "0",
          "title": "Is this transaction an income or expense?",
          "description": "Please specify the type of transaction.",
          "remark": false,
          "type": "dropdown",
          "is_mandatory": true
        },
        {
          "question_id": "1",
          "fields": [],
          "_id": "1",
          "title": "USD Amount",
          "description": "Please enter the \$ amount of the transaction.",
          "type": "text",
          "maxline": 1,
          "remark": false,
          "is_mandatory": true
        },
        {
          "question_id": "2",
          "fields": [],
          "_id": "2",
          "title": "Transaction Item Detail",
          "description": "Description of item bought or received.",
          "remark": false,
          "type": "text",
          "is_mandatory": true
        },
        {
          "question_id": "3",
          "fields": [],
          "_id": "4",
          "title": "Transaction Company",
          "description": "Please specify the where the transaction occured.",
          "remark": false,
          "type": "text",
          "is_mandatory": true
        },
        {
          "question_id": "3",
          "fields": [
            "Income",
            "Expense",
            "Finance",
            "Personal",
            "Food",
            "Clothes",
            "Health",
            "Electronics",
            "Fun",
            "Other"
          ],
          "_id": "4",
          "title": "Transaction Cateogry",
          "description": "please select one of the options below.",
          "remark": false,
          "type": "dropdown",
          "is_mandatory": true
        },
      ]
    },
  ]
};
