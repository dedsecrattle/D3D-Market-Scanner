
# D3D Data Scrapper API

An API created to Scrap Financial Data from Various Sources created with Python using Flask to Serve as a REST API


## API Reference

#### Get Financial Data

```http
/fundamental-data
```

| Parameter | Return Type     | Description                |
| :-------- | :------- | :------------------------- |
| `fundamental-data` | `json` | Returns the Fundamental Data for Currencies |

#### Get COT Data

```http
/cot-data
```

| Parameter | Return Type     | Description                |
| :-------- | :------- | :------------------------- |
| `cot-data` | `json` | Returns the COT Data for Currencies |

#### Get Financial Data


/retail-data

| Parameter | Return Type     | Description                |
| :-------- | :------- | :------------------------- |
| `retail-data` | `json` | Returns the Retail Data for Currency Pair |


For Test Use the Following Link -

Server (Render) - 
https://d3d-financial-data-api.onrender.com



