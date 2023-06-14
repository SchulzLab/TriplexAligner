# get_codes ---------------------------------------------------------------

#' Returns log-odds substitution matrices learned from triplex-sequencing data
#' 
#' Returns the substitution matrices which were learned by expectation-maximisation from triplexRNA-seq and triplexDNA-seq data.
#' @keywords code matrix log-odds
#' @export
#' @examples
#' get_codes()

get_codes = function(){
  dimnames = list(c('A','C','G','T','N'), c('A','C','G','T','N'))
  CF1 = matrix(data = c(-23.25,-21.90,-21.75,5.77,-37.74,
                  -1.23,-1.21,-1.06,2.76,-37.74,
                  -1.39,-1.38,-1.20,2.88,-37.74,
                  -37.74,-27.88,-21.35,5.91,-37.74,
                  -37.74,-37.74,-37.74,-37.74,-37.74), 
               byrow = T, nrow = 5, ncol = 5, dimnames = dimnames)
  
  CF2 = matrix(data = c(-29.62,-29.62,-24.29,5.78,-29.62,
                        -4.87,-4.87,-4.73,5.04,-29.62,
                        -6.45,-6.37,-6.3,5.39,-29.62,
                        -11.75,-10.57,-11.25,5.66,-29.62,
                        -29.62,-29.62,-29.62,-29.62,-29.62), 
               byrow = T, nrow = 5, ncol = 5, dimnames = dimnames)
  
  CF3 = matrix(data = c(5.79,-161.83,-45.65,-33,-166.53,
                        2.73,-1.14,-1.14,-1.14,-166.53,
                        2.61,-1.11,-1.11,-1.11,-166.53,
                        5.92,-161.37,-32.64,-166.53,-166.53,
                        -166.53,-166.53,-166.53,-166.53,-166.53), 
               byrow = T, nrow = 5, ncol = 5, dimnames = dimnames)
  
  CF4 = matrix(data = c(5.3,-9.82,-7.61,-8.96,-9.82,
                        5.43,-6.36,-6.36,-6.36,-9.82,
                        4.75,-4.09,-4.09,-4.09,-9.82,
                        5.21,-7.08,-7.03,-7.03,-9.82,
                        -9.82,-9.82,-9.82,-9.82,-9.82), 
               byrow = T, nrow = 5, ncol = 5, dimnames = dimnames)
  
  CF4 = matrix(data = c(5.3,-9.82,-7.61,-8.96,-9.82,
                        5.43,-6.36,-6.36,-6.36,-9.82,
                        4.75,-4.09,-4.09,-4.09,-9.82,
                        5.21,-7.08,-7.03,-7.03,-9.82,
                        -9.82,-9.82,-9.82,-9.82,-9.82), 
               byrow = T, nrow = 5, ncol = 5, dimnames = dimnames)
  
  CF5 = matrix(data = c(-5.3,-5.28,-5.49,4.65,-5.49,
                        -4.01,-4.1,4.92,-5.37,-5.49,
                        -4.61,4.47,-3.2,-2.81,-5.49,
                        4.01,-4.29,-2.54,-3.34,-5.49,
                        -5.49,-5.49,-5.49,-5.49,-5.49), 
               byrow = T, nrow = 5, ncol = 5, dimnames = dimnames)
  
  CF6 = matrix(data = c(-0.95,-0.15,-1.16,0.98,-17.06,
                        -0.07,-0.52,1.45,-0.38,-17.06,
                        -11.17,-9.52,-11.13,5.9,-17.06,
                        -16.2,-17.06,5.77,-10.58,-17.06,
                        -17.06,-17.06,-17.06,-17.06,-17.06), 
               byrow = T, nrow = 5, ncol = 5, dimnames = dimnames)
  
  CF7 = matrix(data = c(3.77,-3.92,-2.26,-3.88,-5.55,
                        -4.08,4.41,-3.45,-2.38,-5.55,
                        -4.17,-4.35,4.94,-5.55,-5.55,
                        -4.26,-4.3,-4.07,4.42,-5.55,
                        -5.55,-5.55,-5.55,-5.55,-5.55), 
               byrow = T, nrow = 5, ncol = 5, dimnames = dimnames)
  
  CF8 = matrix(data = c(-0.36,0.6,-0.26,-1.09,-5.67,
                        -1.67,0.5,-0.66,1.82,-5.67,
                        -1.2,0.38,1.71,-0.87,-5.67,
                        -5.03,0.19,-5.67,3.57,-5.67,
                        -5.67,-5.67,-5.67,-5.67,-5.67), 
               byrow = T, nrow = 5, ncol = 5, dimnames = dimnames)
  
  codeList = list("Code 1" = CF1,
                  "Code 2" = CF2,
                  "Code 3" = CF3,
                  "Code 4" = CF4,
                  "Code 5" = CF5,
                  "Code 6" = CF6,
                  "Code 7" = CF7,
                  "Code 8" = CF8)
  
  return(codeList)
  
}
