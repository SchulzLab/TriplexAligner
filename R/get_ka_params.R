# get_ka_params ---------------------------------------------------------------

#' Returns Karlin-Altschul parameters for TriplexAligner substitution matrices
#' 
#' Returns the Karlin-Altschul parameters for substitution matrices which were learned by expectation-maximisation from triplexRNA-seq and triplexDNA-seq data.
#' @keywords code matrix log-odds parameters Karlin Altschul
#' @export
#' @examples
#' get_ka_params()

get_ka_params = function(){
  
  ka1 = list(Lambda = 0.35,
             K = 0.2596695) 
  
  ka2 = list(Lambda = 0.36,
             K = 0.2671193) 
  
  ka3 = list(Lambda = 0.35,
             K = 0.2512554) 
  
  ka4 = list(Lambda = 0.41,
             K = 0.3929738) 
  
  ka5 = list(Lambda = 0.39,
             K = 0.2499883) 
  
  ka6 = list(Lambda = 0.39,
             K = 0.3196539) 
  
  ka7 = list(Lambda = 0.37,
             K = 0.2100082) 
  
  ka8 = list(Lambda = 0.39,
             K = 0.3804839)
  
  ka_list = list("Code 1" = ka1,
                 "Code 2" = ka2,
                 "Code 3" = ka3,
                 "Code 4" = ka4,
                 "Code 5" = ka5,
                 "Code 6" = ka6,
                 "Code 7" = ka7,
                 "Code 8" = ka8)
  
  return(ka_list)
  
}
