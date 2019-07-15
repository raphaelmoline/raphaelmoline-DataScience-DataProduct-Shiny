## for analysis

library(ggplot2)
library(ggpubr)

diamonds <- filter(diamonds, carat > 0.5 & carat<2.5)

g1 <- ggplot(diamonds, aes(x=carat, y=price)) + 
    geom_point(colour = "blue", alpha = .1) +
    geom_smooth()
g2 <- ggplot(diamonds, aes(x=log(carat), y=log(price))) + 
    geom_point(colour = "blue", alpha = .1) +
    geom_smooth()
g3 <- ggplot(filter(diamonds, carat<=2 & carat > 0.5), aes(x=log(carat), y=log(price))) + 
    geom_point(colour = "blue", alpha = .1) +
    geom_smooth()
g4 <- ggplot(filter(diamonds, carat>2 & carat<2.5), aes(x=log(carat), y=log(price))) + 
    geom_point(colour = "blue", alpha = .1) +
    geom_smooth()

ggarrange(g1,g2,g3,g4,ncol = 2, nrow = 2)


fit <- lm(price ~ carat, diamonds)
fitlog <- lm(log(price) ~ log(carat), diamonds)
fitlog_low <- lm(log(price) ~ log(carat), filter(diamonds, carat<=2))

fit_cut <- lm(log(price) ~ log(carat) + cut, filter(diamonds, carat<=2))
fit_clarity <- lm(log(price) ~ log(carat) + clarity, filter(diamonds, carat<=2))
fit_color <- lm(log(price) ~ log(carat) + color, filter(diamonds, carat<=2))
fit_all <- lm(log(price) ~ log(carat) + cut + color + clarity, filter(diamonds, carat<=2))

summary(fit)$r.squared
summary(fitlog)$r.squared
summary(fitlog_low)$r.squared
summary(fit_cut)$r.squared
summary(fit_clarity)$r.squared
summary(fit_color)$r.squared
summary(fit_all)$r.squared



price <- exp(fit_all$model$`log(price)`)
carat <- exp(fit_all$model$`log(carat)`)
price_res <- (exp(fit_all$fitted.values) - price)
simul = cbind(price, carat, price_res) %>% tbl_df()

g5 <- ggplot(simul, aes(x=carat, y=price)) + geom_point(colour = "blue", alpha = .1) 
g6 <- ggplot(simul, aes(x=carat, y=price_res)) + geom_point(colour = "blue", alpha = .1) 
ggarrange(g5,g6,ncol = 2)