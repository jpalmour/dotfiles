BEGIN { COMPLETED_LINE_NUM = 0 }
# keep everything between '# TODO' and '# Completed'
/# TODO/,/# Completed/
# only keep new lines or markdown headings after '#completed'
/# Completed/ { COMPLETED_LINE_NUM = NR }
( /#/ || length($0) < 1 ) && COMPLETED_LINE_NUM && NR > COMPLETED_LINE_NUM
