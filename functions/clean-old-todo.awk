BEGIN { COMPLETED_LINE_NUM = 0 }
# keep everything after '#completed'
/# Completed/ { COMPLETED_LINE_NUM = NR }
COMPLETED_LINE_NUM && NR >= COMPLETED_LINE_NUM
