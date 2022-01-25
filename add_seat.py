import pymysql

conn = pymysql.connect(host='127.0.0.1', user='root', password='seokmin68', db='study_room', port=3307)
curs = conn.cursor()

for i in range(1, 151): 
    insert_sql = "INSERT INTO seats (number, user) VALUES (%s, %s);"
    val = (i, 'none')
    curs.execute(insert_sql, val)

    conn.commit()

print("150개의 좌석이 데이터 베이스에 저장되었습니다.")