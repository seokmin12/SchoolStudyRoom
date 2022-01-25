import pymysql

conn = pymysql.connect(host='127.0.0.1', user='root', password='seokmin68', db='study_room', port=3307)
curs = conn.cursor()

insert_sql = "INSERT INTO member (grade, name, password, warning, study_start, job, year, created) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
val = ('201', '고재승', '1234', '0', 'NULL', 'teacher', '2022', '2022-01-04')
curs.execute(insert_sql, val)
conn.commit()

print("데이터 베이스에 저장되었습니다.")

