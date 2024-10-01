# Lab II - Discriminant Analysis and Model Selection ####

## LDA ####
library(ElemStatLearn)
data("SAheart")
summary(SAheart)

n<-nrow(SAheart)

### Training + Validation sets ####
set.seed(1234)
index<-sample(1:n,ceiling(n/2),replace=F)

library(MASS)
out.lda<-lda(chd~.,data=SAheart[index,])
out.lda
pred.lda<-predict(out.lda,newdata=SAheart[-index,])

table(Actual=SAheart$chd[-index],LDA=pred.lda$class)
mean(SAheart$chd[-index]!=pred.lda$class)
#0.2640693

## Comparison with Logistic Regression ####
out.lr<-glm(chd~.,data=SAheart[index,],family="binomial")
summary(out.lr)
phat<-predict(out.lr,newdata = SAheart[-index,],type="response")
yhat.lr<-ifelse(phat>0.5,1,0)

table(Actual=SAheart$chd[-index],LR=yhat.lr)
mean(SAheart$chd[-index]!=yhat.lr)
# 0.2683983

table(LDA=pred.lda$class,LR=yhat.lr)

## Model Selection ####
library(ElemStatLearn)
data("prostate")
summary(prostate)

x<-prostate[,-ncol(prostate)]
p<-ncol(x)-1

#install.packages(leaps)
library(leaps)
### Best subset selection ####
out.bs<-regsubsets(lpsa~.,data=x,method="exhaustive")
sum.out.bs<-summary(out.bs)

sum.out.bs$rsq
sum.out.bs$rss
plot(sum.out.bs$adjr2,type="l")

plot(sum.out.bs$bic,type="l")
plot(sum.out.bs$cp,type="l")
which.min(sum.out.bs$cp)

### Forward Selection ####
out.fs<-regsubsets(lpsa~.,data=x,method="forward")
summary(out.fs)

### Backward Elimination ####
out.be<-regsubsets(lpsa~.,data=x,method="backward")
summary(out.be)

### Hybrid Approach ####
out.ha<-regsubsets(lpsa~.,data=x,method="seqrep")
summary(out.ha)


## Model Selection in CV ####
predict.regsubsets<-function(object,newdata,id,...){
  form<-as.formula(object$call[[2]])
  mat<-model.matrix(form,newdata)
  coefi<-coef(object,id=id)
  y.hat<-mat[,names(coefi)]%*%coefi
  return(y.hat)
}

K<-5
set.seed(1234)
folds<-sample(1:K,nrow(x),replace = T)
# table(folds) # check the subdivision into folds
cv.errors<-matrix(NA,K,p,dimnames = list(NULL,paste0("M=",1:p)))

for (i in 1:K){
  best.fit<-regsubsets(lpsa~.,data=x[folds!=i,])
  for (j in 1:p){
    pred<-predict(best.fit,newdata=x[folds==i,],id=j)
    cv.errors[i,j]<-mean((x$lpsa[folds==i]-pred)^2) # MSE in the ith fold and 
                            # for the model with j predictors
  }
}

apply(cv.errors,2,mean)
plot(apply(cv.errors,2,mean),type="b")
