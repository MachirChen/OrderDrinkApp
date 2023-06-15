////
////  MenuFromJson.swift
////  OrderDrinkApp
////
////  Created by Machir on 2023/6/10.
////
//
//import Foundation
//
//EXAMPLE REQUEST
//curl "https://api.airtable.com/v0/appgfDIC0LO9O3n4q/Menu?maxRecords=3&view=Grid%20view" \
//  -H "Authorization: Bearer YOUR_SECRET_API_TOKEN"
//EXAMPLE RESPONSE
//{
//    "records": [
//        {
//            "id": "recAvI0y1paCOqtzB",
//            "createdTime": "2023-06-09T13:37:23.000Z",
//            "fields": {
//                "image": [
//                    {
//                        "id": "attQcLF53M5g04qvw",
//                        "width": 380,
//                        "height": 380,
//                        "url": "https://v5.airtableusercontent.com/v1/17/17/1686376800000/EzvNqdPKAkyKNqVMt3zVqQ/6gLxkENOAUZm9wY8OViEsIomLFmZATXaSHnLQ6w5-ISD6hgoqaZ4AUspvx7G_UhAEMfTKsjOVHyYObOyEYmpBw/aOHD8Y4umG4zLUN2B5IFlDyDryz-zXxXUufH7Voa-EU",
//                        "filename": "冷露檸果.png",
//                        "size": 186961,
//                        "type": "image/png",
//                        "thumbnails": {
//                            "small": {
//                                "url": "https://v5.airtableusercontent.com/v1/17/17/1686376800000/Gu8bNc5SoT-bHj_gNxbHbg/esPWN_dD6St5WFjoFt--zKHTXBSmK5W3PRUcd6yzxpBQT6DD_trMNAkfZ1h1zZPOJ7gkrB-sIAIqb_uIaVX8bA/q7UKUJ8rAhYdDdKh0b7fvYTSfoCli2tLZAlHiqaI_uY",
//                                "width": 36,
//                                "height": 36
//                            },
//                            "large": {
//                                "url": "https://v5.airtableusercontent.com/v1/17/17/1686376800000/IjgXFePbE3F6L61JsyDzVw/GaK-nt9oe4pBsARuSO47wt6XzPf7cR6stvvW5VfQ0d4A2CI3CczLvUVu7nUwagYH38rRWrWennksF9An2BlVsA/yB3qZeYkwUocxnxu82SITrKb-FiIqYsNmGV3_oCxIBk",
//                                "width": 380,
//                                "height": 380
//                            },
//                            "full": {
//                                "url": "https://v5.airtableusercontent.com/v1/17/17/1686376800000/6qOXv8cXJns1fgfzd6PuZA/kqdQ3teMw4WT3gC0ATMy-V8uKJwKKSJb0mtsMxzGhaI76gXUZFV_FAdkTgm2xcbA3gHwnDP53lc01nhf_Zs7Cw/5o6DtdsnH7SUeHyN2NJNPpTuxXgcxUfMIgvnBIxBBi4",
//                                "width": 3000,
//                                "height": 3000
//                            }
//                        }
//                    }
//                ],
//                "description": "古法熬煮冬瓜與整顆鮮切檸檬\n",
//                "large": 65,
//                "medium": 55,
//                "name": "冷露檸果"
//            }
//        },
//        {
//            "id": "recTvNW6rGD3RMALJ",
//            "createdTime": "2023-06-09T13:37:23.000Z",
//            "fields": {
//                "image": [
//                    {
//                        "id": "attUdn42femglLHAY",
//                        "width": 380,
//                        "height": 380,
//                        "url": "https://v5.airtableusercontent.com/v1/17/17/1686376800000/_mZjHZs9webrzVjosj4Mgw/MSX7FYBFear7oNEdUvlIHwwNuijbpkgSMlmZWjJYiK8kXl-4dIuKoTvXaD6ejNTTJA9CYzHtuMt7nZ7pX-7KMQ/eyFYhdEp1hKNZq3MYrsITKnlMgm19lwCguiTrPPGflY",
//                        "filename": "熟成紅茶.png",
//                        "size": 257551,
//                        "type": "image/png",
//                        "thumbnails": {
//                            "small": {
//                                "url": "https://v5.airtableusercontent.com/v1/17/17/1686376800000/9y8ts73boGAHRW3j-eA6Xw/JiUHctF0A8UFIpRdlTm01aMyucXvCBZ_Ov-SjEvMuphZpHazy_R1K9WmtLj8AFd-GZH9695GzA9-_w3UTif04A/kH0sfnyDF_Ff7X-v-nhacQPsS-fY3TsRbkjXutNXFNA",
//                                "width": 36,
//                                "height": 36
//                            },
//                            "large": {
//                                "url": "https://v5.airtableusercontent.com/v1/17/17/1686376800000/tH97P_yCs6jR5qtxlCtUhA/2-U3BU9rclkdvugU8gqqJHCPsAFFETS_uuUBE_WdhOmCl24tsMn34xCA4IuYZgQWupQVORVzxRUEXoVnFQbSJA/4sjClybEQ-QNbta1YYG_gx9LrAcQRYAJf0hzSme0vcc",
//                                "width": 380,
//                                "height": 380
//                            },
//                            "full": {
//                                "url": "https://v5.airtableusercontent.com/v1/17/17/1686376800000/vbONk39fM8v6OVMersHJQw/qL0eYrLtemGsY_0J4_5DALLekmH0KmWRkjrZMheUMzMxuTSXa2mdgpzo4s6q4inPV_tpiJqkaycyQitI8XyY4A/Ob5cCNiwPgOKJpZ9aGeoR0K0yf_0L8rVXEjNSw0qlj8",
//                                "width": 3000,
//                                "height": 3000
//                            }
//                        }
//                    }
//                ],
//                "description": "解炸物/燒烤肉類油膩，茶味濃郁帶果香\n",
//                "large": 35,
//                "medium": 30,
//                "name": "熟成紅茶"
//            }
//        },
//        {
//            "id": "recKVbURAPnHBR0Eh",
//            "createdTime": "2023-06-09T13:37:23.000Z",
//            "fields": {
//                "image": [
//                    {
//                        "id": "attOiHbrdOYSJbkDU",
//                        "width": 380,
//                        "height": 380,
//                        "url": "https://v5.airtableusercontent.com/v1/17/17/1686376800000/kvPw10VyART6fKmG4K1HEQ/7iPNQZT4CUMyK4B_i_mBDS3C7sHkGbxbgzUtQ0fxdMFKtrmKxFbNRy0crzSJY4qJuk25dtSB2xtFpOokPFn-cQ/0ELM_2w46nVhvLNQL6jeU4y97hGMOhuHb4sOw85pGKM",
//                        "filename": "麗春紅茶.png",
//                        "size": 262894,
//                        "type": "image/png",
//                        "thumbnails": {
//                            "small": {
//                                "url": "https://v5.airtableusercontent.com/v1/17/17/1686376800000/87BDtrBberzyoTTZqlFUgA/ZVmLdLHS9KJ9xt4aozD_NQL1EFlmJ4hnbnRQa1BAbb74cTaHgjK10qiiB8Uy-kRMcHXuuZs1QYR1qt-ztNWz5g/MuPYt80knjjCPzkOB_7QOizETbC3_qxxfAqlCl0EOpY",
//                                "width": 36,
//                                "height": 36
//                            },
//                            "large": {
//                                "url": "https://v5.airtableusercontent.com/v1/17/17/1686376800000/gbiXjJxo8pxOpk7CKIxTrg/asAp9rmjckE_OVAH1RJ1cCchYKLbqzzra2M7KnJtGJOgGX0VMGa4EnjOry2Br7nHigHdj4VlLuaCz1BY9sOzLw/s5wkYkAn4T7dBzaB_0F1bcp5PM83M7mZAAxgCOqej2A",
//                                "width": 380,
//                                "height": 380
//                            },
//                            "full": {
//                                "url": "https://v5.airtableusercontent.com/v1/17/17/1686376800000/WgJt8jD978kDOC8obs2Iaw/uNaEGAZoK_jeg60qT1tckaCfsfe3R8ZxIcwnzfPQNsZ8idA-302zXGFHzqExeRQtlNszbzCCk-_91lqj8Kb0pQ/mIdbFhECso9QkVyQT0bpFANHj4EcVvUzP9NIrT_0Exs",
//                                "width": 3000,
//                                "height": 3000
//                            }
//                        }
//                    }
//                ],
//                "description": "去除海鮮羶腥，茶味較淡帶花香",
//                "large": 35,
//                "medium": 30,
//                "name": "麗春紅茶"
//            }
//        }
//    ],
//    "offset": "itrxJwmN1BoffJXrk/recKVbURAPnHBR0Eh"
//}
