source("LassoFunctions.R")

############ Make the Lambda extremely large. We should get zero betas

n_test <- 50
p_test <- 10
X_test <- matrix(rnorm(n_test * p_test), nrow = n_test, ncol = p_test)
Y_test <- rnorm(n_test)

large_lambda <- c(100)

fit_large_lambda <- fitLASSO(X_test, Y_test, lambda_seq = large_lambda)

# Check if all beta coefs are zero

all(fit_large_lambda$beta_mat == 0)

# Intercept should be mean of Y

fit_large_lambda$beta0_vec[1] 
mean(Y_test)

############ Make the Lambda extremely small. We should get OLS estimators

true_beta <- 1:p_test
Y_test <- X_test %*% true_beta + rnorm(n_test)

# Make lambdas zero and make sure eps is small so the objective minimum matches the ols results
fitLASSO(X_test, Y_test, lambda_seq = c(0), eps = 1e-10)

lm(Y_test ~ X_test)$coef
