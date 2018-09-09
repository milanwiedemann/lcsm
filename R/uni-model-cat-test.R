a <- "

ly1 =~ 1 * y1 
ly2 =~ 1 * y2 
ly3 =~ 1 * y3 
ly4 =~ 1 * y4 
ly5 =~ 1 * y5 
ly6 =~ 1 * y6 
ly7 =~ 1 * y7 

ly1 ~ gamma_ly1 * 1 
ly2 ~ 0 * 1 
ly3 ~ 0 * 1 
ly4 ~ 0 * 1 
ly5 ~ 0 * 1 
ly6 ~ 0 * 1 
ly7 ~ 0 * 1 

ly1 ~~ sigma2_ly1 * ly1 
ly2 ~~ 0 * ly2 
ly3 ~~ 0 * ly3 
ly4 ~~ 0 * ly4 
ly5 ~~ 0 * ly5 
ly6 ~~ 0 * ly6 
ly7 ~~ 0 * ly7 

y1 ~ 0 * 1 
y2 ~ 0 * 1 
y3 ~ 0 * 1 
y4 ~ 0 * 1 
y5 ~ 0 * 1 
y6 ~ 0 * 1 
y7 ~ 0 * 1 

y1 ~~ sigma2_uy * y1 
y2 ~~ sigma2_uy * y2 
y3 ~~ sigma2_uy * y3 
y4 ~~ sigma2_uy * y4 
y5 ~~ sigma2_uy * y5 
y6 ~~ sigma2_uy * y6 
y7 ~~ sigma2_uy * y7 

ly2 ~ 1 * ly1 
ly3 ~ 1 * ly2 
ly4 ~ 1 * ly3 
ly5 ~ 1 * ly4 
ly6 ~ 1 * ly5 
ly7 ~ 1 * ly6 

dy2 =~ 1 * ly2 
dy3 =~ 1 * ly3 
dy4 =~ 1 * ly4 
dy5 =~ 1 * ly5 
dy6 =~ 1 * ly6 
dy7 =~ 1 * ly7 

dy2 ~ 1 * 0 
dy3 ~ 1 * 0 
dy4 ~ 1 * 0 
dy5 ~ 1 * 0 
dy6 ~ 1 * 0 
dy7 ~ 1 * 0 

dy2 ~~ 0 * dy2 
dy3 ~~ 0 * dy3 
dy4 ~~ 0 * dy4 
dy5 ~~ 0 * dy5 
dy6 ~~ 0 * dy6 
dy7 ~~ 0 * dy7 

g2 =~ 1 * dy2 + 1 * dy3 + 1 * dy4 + 1 * dy5 + 1 * dy6 + 1 * dy7 
g2 ~ gamma_g2 * 1 
g2 ~~ sigma2_g2 * g2 
g2 ~~ sigma_g2ly1 * ly1

dy2 ~ pi_y * ly1 
dy3 ~ pi_y * ly2 
dy4 ~ pi_y * ly3 
dy5 ~ pi_y * ly4 
dy6 ~ pi_y * ly5 
dy7 ~ pi_y * ly6 
"
