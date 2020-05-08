clc
clear all
close all
loadData_gr
SIDnum = unique(grdata.SubjectID);
grdata.Trial = categorical(grdata.Trial);
grdata.SubjectID = categorical(grdata.SubjectID);
grdata.Texture = categorical(grdata.Texture);
toDelete = grdata.Trial == 'Trial 1';
grdata(toDelete,:) = [];
grdata.log_PLFR = log(grdata.PLFR);
grdata.log_PGFR = log(grdata.PGFR);
grdata.Weightcentered = grdata.Weight - mean(unique(grdata.Weight));
SID = unique(grdata.SubjectID);
Weight = unique(grdata.Weight);

%% PLFR vs. Weight (Linear model)

plfr_weight_ols = fitlm(grdata,'PLFR ~ Weightcentered');
plfr_lme1_linear = fitlme(grdata(grdata.Texture == 'C1',:),'PLFR ~ 1 + Weightcentered');
plfr_lme2_linear = fitlme(grdata(grdata.Texture == 'C1',:),'PLFR ~ 1 + Weightcentered + (1|SubjectID)');
plfr_lme3_linear = fitlme(grdata(grdata.Texture == 'C1',:),'PLFR ~ 1 + Weightcentered + (1 + Weightcentered|SubjectID)');
fe = fixedEffects(plfr_lme3_linear);
[~,~,re] = randomEffects(plfr_lme3_linear);
re.Level = nominal(re.Level);
re.Name = nominal(re.Name);
plfr_lme4_linear = fitlme(grdata(grdata.Texture == 'C1',:),'PLFR ~ 1 + Weightcentered + (1 + Weightcentered|SubjectID)+ (1|Trial)');
            comp_plfr = compare(plfr_lme1_linear,plfr_lme2_linear,'nsim',100);
            comp_plfr1 = compare(plfr_lme2_linear,plfr_lme3_linear,'nsim',100);
            comp_plfr2 = compare(plfr_lme3_linear,plfr_lme4_linear,'nsim',100);
plfr_lm_1 = fitlm(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).PLFR);
plfr_lm_2 = fitlm(grdata(grdata.SubjectID==SID(2)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(2)  & grdata.Texture == 'C1',:).PLFR);
plfr_lm_3 = fitlm(grdata(grdata.SubjectID==SID(3)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(3)  & grdata.Texture == 'C1',:).PLFR);
plfr_lm_4 = fitlm(grdata(grdata.SubjectID==SID(4)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(4)  & grdata.Texture == 'C1',:).PLFR);
plfr_lm_5 = fitlm(grdata(grdata.SubjectID==SID(5)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(5)  & grdata.Texture == 'C1',:).PLFR);
plfr_lm_6 = fitlm(grdata(grdata.SubjectID==SID(6)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(6)  & grdata.Texture == 'C1',:).PLFR);
plfr_lm_7 = fitlm(grdata(grdata.SubjectID==SID(7)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(7)  & grdata.Texture == 'C1',:).PLFR);
plfr_lm_8 = fitlm(grdata(grdata.SubjectID==SID(8)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(8)  & grdata.Texture == 'C1',:).PLFR);
plfr_lm_9 = fitlm(grdata(grdata.SubjectID==SID(9)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(9)  & grdata.Texture == 'C1',:).PLFR);
plfr_lm_10 = fitlm(grdata(grdata.SubjectID==SID(10)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(10)  & grdata.Texture == 'C1',:).PLFR);
plfr_lm_11 = fitlm(grdata(grdata.SubjectID==SID(11)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(11)  & grdata.Texture == 'C1',:).PLFR);
plfr_lm_12 = fitlm(grdata(grdata.SubjectID==SID(12)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(12)  & grdata.Texture == 'C1',:).PLFR);
plfr_lm_13 = fitlm(grdata(grdata.SubjectID==SID(13)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(13)  & grdata.Texture == 'C1',:).PLFR);
plfr_lm_14 = fitlm(grdata(grdata.SubjectID==SID(14)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(14)  & grdata.Texture == 'C1',:).PLFR);
plfr_lm_15 = fitlm(grdata(grdata.SubjectID==SID(15)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(15)  & grdata.Texture == 'C1',:).PLFR);

f1 = figure(1);
hold on
sgtitle('Peak Load Force Rate (N/s) vs. weight (Linear realtionship')

subplot(3,5,1)
hold on
A1 = scatter(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).PLFR,'*r','DisplayName','PLFR');
B1 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,plfr_lm_1.Coefficients.Estimate(1)+plfr_lm_1.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2,'DisplayName','OLS-model');
C1 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(1))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(1))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2,'DisplayName','LME-model');
hold off

subplot(3,5,2)
hold on
scatter(grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight,plfr_lm_2.Coefficients.Estimate(1)+plfr_lm_2.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(2))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(2))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,3)
hold on
scatter(grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight,plfr_lm_3.Coefficients.Estimate(1)+plfr_lm_3.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(3))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(3))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,4)
hold on
scatter(grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight,plfr_lm_4.Coefficients.Estimate(1)+plfr_lm_4.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(4))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(4))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,5)
hold on
scatter(grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight,plfr_lm_5.Coefficients.Estimate(1)+plfr_lm_5.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(5))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(5))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,6)
hold on
scatter(grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight,plfr_lm_6.Coefficients.Estimate(1)+plfr_lm_6.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(6))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(6))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,7)
hold on
scatter(grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight,plfr_lm_7.Coefficients.Estimate(1)+plfr_lm_7.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(7))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(7))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,8)
hold on
scatter(grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight,plfr_lm_8.Coefficients.Estimate(1)+plfr_lm_8.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(8))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(8))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,9)
hold on
scatter(grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight,plfr_lm_9.Coefficients.Estimate(1)+plfr_lm_9.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(9))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(9))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,10)
hold on
scatter(grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight,plfr_lm_10.Coefficients.Estimate(1)+plfr_lm_10.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(10))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(10))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,11)
hold on
scatter(grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight,plfr_lm_11.Coefficients.Estimate(1)+plfr_lm_11.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(11))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(11))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,12)
hold on
scatter(grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight,plfr_lm_12.Coefficients.Estimate(1)+plfr_lm_12.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(2))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(12))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,13)
hold on
scatter(grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight,plfr_lm_13.Coefficients.Estimate(1)+plfr_lm_13.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(13))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(13))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,14)
hold on
scatter(grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight,plfr_lm_14.Coefficients.Estimate(1)+plfr_lm_14.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(14))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(14))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,15)
hold on
scatter(grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight,plfr_lm_15.Coefficients.Estimate(1)+plfr_lm_15.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(15))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(15))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

han1 = axes(f1,'visible','off');
han1.XLabel.Visible = 'on';
han1.YLabel.Visible = 'on';
xlabel(han1,'Object mass (grams)','FontSize',20);
ylabel(han1,'PLFR: Peak Load Force Rate (N/s)','FontSize',20);
lgd1 = legend([A1,B1,C1],'FontSize',20);
% set(lgd2,'MarkerSize',20);
lgd1.Orientation = 'horizontal';

%% PLFR vs. Weight (log-linear)

lplfr_weight_ols = fitlm(grdata,'log_PLFR ~ Weightcentered');
lplfr_lme1_loglinear = fitlme(grdata(grdata.Texture == 'C1',:),'log_PLFR ~ 1 + Weightcentered');
lplfr_lme2_loglinear = fitlme(grdata(grdata.Texture == 'C1',:),'log_PLFR ~ 1 + Weightcentered + (1|SubjectID)');
lplfr_lme3_loglinear = fitlme(grdata(grdata.Texture == 'C1',:),'log_PLFR ~ 1 + Weightcentered + (1 + Weightcentered|SubjectID)');
lfe = fixedEffects(lplfr_lme3_loglinear);
[~,~,lre] = randomEffects(lplfr_lme3_loglinear);
lre.Level = nominal(lre.Level);
lre.Name = nominal(lre.Name);
lplfr_lme4_loglinear = fitlme(grdata(grdata.Texture == 'C1',:),'log_PLFR ~ 1 + Weightcentered + (1 + Weightcentered|SubjectID)+ (1|Trial)');
            comp_plfr = compare(lplfr_lme1_loglinear,lplfr_lme2_loglinear,'nsim',100);
            comp_plfr1 = compare(lplfr_lme2_loglinear,lplfr_lme3_loglinear,'nsim',100);
            comp_plfr2 = compare(lplfr_lme3_loglinear,lplfr_lme4_loglinear,'nsim',100);
lplfr_lm_1 = fitlm(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).log_PLFR);
lplfr_lm_2 = fitlm(grdata(grdata.SubjectID==SID(2)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(2)  & grdata.Texture == 'C1',:).log_PLFR);
lplfr_lm_3 = fitlm(grdata(grdata.SubjectID==SID(3)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(3)  & grdata.Texture == 'C1',:).log_PLFR);
lplfr_lm_4 = fitlm(grdata(grdata.SubjectID==SID(4)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(4)  & grdata.Texture == 'C1',:).log_PLFR);
lplfr_lm_5 = fitlm(grdata(grdata.SubjectID==SID(5)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(5)  & grdata.Texture == 'C1',:).log_PLFR);
lplfr_lm_6 = fitlm(grdata(grdata.SubjectID==SID(6)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(6)  & grdata.Texture == 'C1',:).log_PLFR);
lplfr_lm_7 = fitlm(grdata(grdata.SubjectID==SID(7)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(7)  & grdata.Texture == 'C1',:).log_PLFR);
lplfr_lm_8 = fitlm(grdata(grdata.SubjectID==SID(8)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(8)  & grdata.Texture == 'C1',:).log_PLFR);
lplfr_lm_9 = fitlm(grdata(grdata.SubjectID==SID(9)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(9)  & grdata.Texture == 'C1',:).log_PLFR);
lplfr_lm_10 = fitlm(grdata(grdata.SubjectID==SID(10)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(10)  & grdata.Texture == 'C1',:).log_PLFR);
lplfr_lm_11 = fitlm(grdata(grdata.SubjectID==SID(11)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(11)  & grdata.Texture == 'C1',:).log_PLFR);
lplfr_lm_12 = fitlm(grdata(grdata.SubjectID==SID(12)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(12)  & grdata.Texture == 'C1',:).log_PLFR);
lplfr_lm_13 = fitlm(grdata(grdata.SubjectID==SID(13)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(13)  & grdata.Texture == 'C1',:).log_PLFR);
lplfr_lm_14 = fitlm(grdata(grdata.SubjectID==SID(14)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(14)  & grdata.Texture == 'C1',:).log_PLFR);
lplfr_lm_15 = fitlm(grdata(grdata.SubjectID==SID(15)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(15)  & grdata.Texture == 'C1',:).log_PLFR);

f2 = figure(2);
hold on
sgtitle('Peak Load Force Rate (N/s) for individual subjects (Log-linear relationship)')

subplot(3,5,1)
hold on
A2 = scatter(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).PLFR,'*r','DisplayName','PLFR');
B2 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_1.Coefficients.Estimate(1)+lplfr_lm_1.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2,'DisplayName','OLS-model');
C2 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(1))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(1))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2,'DisplayName','LME-model');
hold off

subplot(3,5,2)
hold on
scatter(grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_2.Coefficients.Estimate(1)+lplfr_lm_2.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(2))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(2))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,3)
hold on
scatter(grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_3.Coefficients.Estimate(1)+lplfr_lm_3.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(3))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(3))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,4)
hold on
scatter(grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_4.Coefficients.Estimate(1)+lplfr_lm_4.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(4))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(4))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,5)
hold on
scatter(grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_5.Coefficients.Estimate(1)+lplfr_lm_5.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(5))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(5))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,6)
hold on
scatter(grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_6.Coefficients.Estimate(1)+lplfr_lm_6.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(6))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(6))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,7)
hold on
scatter(grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_7.Coefficients.Estimate(1)+lplfr_lm_7.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(7))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(7))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,8)
hold on
scatter(grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_8.Coefficients.Estimate(1)+lplfr_lm_8.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(8))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(8))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,9)
hold on
scatter(grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_9.Coefficients.Estimate(1)+lplfr_lm_9.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(9))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(9))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,10)
hold on
scatter(grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_10.Coefficients.Estimate(1)+lplfr_lm_10.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(10))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(10))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,11)
hold on
scatter(grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_11.Coefficients.Estimate(1)+lplfr_lm_11.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(11))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(11))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,12)
hold on
scatter(grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_12.Coefficients.Estimate(1)+lplfr_lm_12.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(2))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(12))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,13)
hold on
scatter(grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_13.Coefficients.Estimate(1)+lplfr_lm_13.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(13))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(13))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,14)
hold on
scatter(grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_14.Coefficients.Estimate(1)+lplfr_lm_14.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(14))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(14))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,15)
hold on
scatter(grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_15.Coefficients.Estimate(1)+lplfr_lm_15.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(15))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(15))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

han2 = axes(f2,'visible','off');
han2.XLabel.Visible = 'on';
han2.YLabel.Visible = 'on';
xlabel(han2,'Object mass (grams)','FontSize',20);
ylabel(han2,'PLFR: Peak Load Force Rate (N/s)','FontSize',20);
lgd2 = legend([A2,B2,C2],'FontSize',20);
% set(lgd2,'MarkerSize',20);
lgd2.Orientation = 'horizontal';

%% PGFR vs. Weight (log-linear)

lpgfr_weight_ols = fitlm(grdata,'log_PGFR ~ Weightcentered');
lpgfr_lme1_loglinear = fitlme(grdata(grdata.Texture == 'C1',:),'log_PGFR ~ 1 + Weightcentered');
lpgfr_lme2_loglinear = fitlme(grdata(grdata.Texture == 'C1',:),'log_PGFR ~ 1 + Weightcentered + (1|SubjectID)');
lpgfr_lme3_loglinear = fitlme(grdata(grdata.Texture == 'C1',:),'log_PGFR ~ 1 + Weightcentered + (1 + Weightcentered|SubjectID)');
lfe = fixedEffects(lpgfr_lme3_loglinear);
[~,~,lre] = randomEffects(lpgfr_lme3_loglinear);
lre.Level = nominal(lre.Level);
lre.Name = nominal(lre.Name);
lpgfr_lme4_loglinear = fitlme(grdata(grdata.Texture == 'C1',:),'log_PGFR ~ 1 + Weightcentered + (1 + Weightcentered|SubjectID)+ (1|Trial)');
            comp_pgfr_llinear = compare(lpgfr_lme1_loglinear,lpgfr_lme2_loglinear,'nsim',100);
            comp_pgfr1_llinear = compare(lpgfr_lme2_loglinear,lpgfr_lme3_loglinear,'nsim',100);
            comp_pgfr2_llinear = compare(lpgfr_lme3_loglinear,lpgfr_lme4_loglinear,'nsim',100);
lplfr_lm_1 = fitlm(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).log_PGFR);
lplfr_lm_2 = fitlm(grdata(grdata.SubjectID==SID(2)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(2)  & grdata.Texture == 'C1',:).log_PGFR);
lplfr_lm_3 = fitlm(grdata(grdata.SubjectID==SID(3)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(3)  & grdata.Texture == 'C1',:).log_PGFR);
lplfr_lm_4 = fitlm(grdata(grdata.SubjectID==SID(4)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(4)  & grdata.Texture == 'C1',:).log_PGFR);
lplfr_lm_5 = fitlm(grdata(grdata.SubjectID==SID(5)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(5)  & grdata.Texture == 'C1',:).log_PGFR);
lplfr_lm_6 = fitlm(grdata(grdata.SubjectID==SID(6)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(6)  & grdata.Texture == 'C1',:).log_PGFR);
lplfr_lm_7 = fitlm(grdata(grdata.SubjectID==SID(7)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(7)  & grdata.Texture == 'C1',:).log_PGFR);
lplfr_lm_8 = fitlm(grdata(grdata.SubjectID==SID(8)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(8)  & grdata.Texture == 'C1',:).log_PGFR);
lplfr_lm_9 = fitlm(grdata(grdata.SubjectID==SID(9)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(9)  & grdata.Texture == 'C1',:).log_PGFR);
lplfr_lm_10 = fitlm(grdata(grdata.SubjectID==SID(10)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(10)  & grdata.Texture == 'C1',:).log_PGFR);
lplfr_lm_11 = fitlm(grdata(grdata.SubjectID==SID(11)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(11)  & grdata.Texture == 'C1',:).log_PGFR);
lplfr_lm_12 = fitlm(grdata(grdata.SubjectID==SID(12)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(12)  & grdata.Texture == 'C1',:).log_PGFR);
lplfr_lm_13 = fitlm(grdata(grdata.SubjectID==SID(13)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(13)  & grdata.Texture == 'C1',:).log_PGFR);
lplfr_lm_14 = fitlm(grdata(grdata.SubjectID==SID(14)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(14)  & grdata.Texture == 'C1',:).log_PGFR);
lplfr_lm_15 = fitlm(grdata(grdata.SubjectID==SID(15)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(15)  & grdata.Texture == 'C1',:).log_PGFR);

f3 = figure(3);
hold on
sgtitle('Peak Grip Force Rate (N/s) for individual subjects (Log-linear relationship)')

subplot(3,5,1)
hold on
A3 = scatter(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).PGFR,'*r','DisplayName','PGFR');
B3 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_1.Coefficients.Estimate(1)+lplfr_lm_1.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2,'DisplayName','OLS-model');
C3 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(1))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(1))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2,'DisplayName','LME-model');
hold off

subplot(3,5,2)
hold on
scatter(grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_2.Coefficients.Estimate(1)+lplfr_lm_2.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(2))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(2))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,3)
hold on
scatter(grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_3.Coefficients.Estimate(1)+lplfr_lm_3.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(3))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(3))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,4)
hold on
scatter(grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_4.Coefficients.Estimate(1)+lplfr_lm_4.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(4))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(4))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,5)
hold on
scatter(grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_5.Coefficients.Estimate(1)+lplfr_lm_5.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(5))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(5))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,6)
hold on
scatter(grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_6.Coefficients.Estimate(1)+lplfr_lm_6.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(6))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(6))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,7)
hold on
scatter(grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_7.Coefficients.Estimate(1)+lplfr_lm_7.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(7))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(7))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,8)
hold on
scatter(grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_8.Coefficients.Estimate(1)+lplfr_lm_8.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(8))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(8))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,9)
hold on
scatter(grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_9.Coefficients.Estimate(1)+lplfr_lm_9.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(9))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(9))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,10)
hold on
scatter(grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_10.Coefficients.Estimate(1)+lplfr_lm_10.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(10))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(10))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,11)
hold on
scatter(grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_11.Coefficients.Estimate(1)+lplfr_lm_11.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(11))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(11))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,12)
hold on
scatter(grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_12.Coefficients.Estimate(1)+lplfr_lm_12.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(2))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(12))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,13)
hold on
scatter(grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_13.Coefficients.Estimate(1)+lplfr_lm_13.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(13))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(13))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,14)
hold on
scatter(grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_14.Coefficients.Estimate(1)+lplfr_lm_14.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(14))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(14))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

subplot(3,5,15)
hold on
scatter(grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight,exp(lplfr_lm_15.Coefficients.Estimate(1)+lplfr_lm_15.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight),'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight,exp(lfe(1)+lre.Estimate(lre.Level == num2str(SIDnum(15))&lre.Name == '(Intercept)')+(lfe(2)+lre.Estimate(lre.Level == num2str(SIDnum(15))&lre.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weightcentered),'-k','LineWidth',2)
hold off

han3 = axes(f3,'visible','off');
han3.XLabel.Visible = 'on';
han3.YLabel.Visible = 'on';
xlabel(han3,'Object mass (grams)','FontSize',20);
ylabel(han3,'PGFR: Peak Load Force Rate (N/s)','FontSize',20);
lgd3 = legend([A3,B3,C3],'FontSize',20);
% set(lgd2,'MarkerSize',20);
lgd3.Orientation = 'horizontal';

%% PGFR vs. Weight (Linear model)

pgfr_weight_ols = fitlm(grdata,'PGFR ~ Weightcentered');
pgfr_lme1_linear = fitlme(grdata(grdata.Texture == 'C1',:),'PGFR ~ 1 + Weightcentered');
pgfr_lme2_linear = fitlme(grdata(grdata.Texture == 'C1',:),'PGFR ~ 1 + Weightcentered + (1|SubjectID)');
pgfr_lme3_linear = fitlme(grdata(grdata.Texture == 'C1',:),'PGFR ~ 1 + Weightcentered + (1 + Weightcentered|SubjectID)');
fe = fixedEffects(pgfr_lme3_linear);
[~,~,re] = randomEffects(pgfr_lme3_linear);
re.Level = nominal(re.Level);
re.Name = nominal(re.Name);
pgfr_lme4_linear = fitlme(grdata(grdata.Texture == 'C1',:),'PGFR ~ 1 + Weightcentered + (1 + Weightcentered|SubjectID)+ (1|Trial)');
            comp_pgfr_linear = compare(pgfr_lme1_linear,pgfr_lme2_linear,'nsim',100);
            comp_pgfr1_linear = compare(pgfr_lme2_linear,pgfr_lme3_linear,'nsim',100);
            comp_pgfr2_linear = compare(pgfr_lme3_linear,pgfr_lme4_linear,'nsim',100);
plfr_lm_1 = fitlm(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).PGFR);
plfr_lm_2 = fitlm(grdata(grdata.SubjectID==SID(2)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(2)  & grdata.Texture == 'C1',:).PGFR);
plfr_lm_3 = fitlm(grdata(grdata.SubjectID==SID(3)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(3)  & grdata.Texture == 'C1',:).PGFR);
plfr_lm_4 = fitlm(grdata(grdata.SubjectID==SID(4)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(4)  & grdata.Texture == 'C1',:).PGFR);
plfr_lm_5 = fitlm(grdata(grdata.SubjectID==SID(5)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(5)  & grdata.Texture == 'C1',:).PGFR);
plfr_lm_6 = fitlm(grdata(grdata.SubjectID==SID(6)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(6)  & grdata.Texture == 'C1',:).PGFR);
plfr_lm_7 = fitlm(grdata(grdata.SubjectID==SID(7)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(7)  & grdata.Texture == 'C1',:).PGFR);
plfr_lm_8 = fitlm(grdata(grdata.SubjectID==SID(8)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(8)  & grdata.Texture == 'C1',:).PGFR);
plfr_lm_9 = fitlm(grdata(grdata.SubjectID==SID(9)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(9)  & grdata.Texture == 'C1',:).PGFR);
plfr_lm_10 = fitlm(grdata(grdata.SubjectID==SID(10)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(10)  & grdata.Texture == 'C1',:).PGFR);
plfr_lm_11 = fitlm(grdata(grdata.SubjectID==SID(11)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(11)  & grdata.Texture == 'C1',:).PGFR);
plfr_lm_12 = fitlm(grdata(grdata.SubjectID==SID(12)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(12)  & grdata.Texture == 'C1',:).PGFR);
plfr_lm_13 = fitlm(grdata(grdata.SubjectID==SID(13)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(13)  & grdata.Texture == 'C1',:).PGFR);
plfr_lm_14 = fitlm(grdata(grdata.SubjectID==SID(14)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(14)  & grdata.Texture == 'C1',:).PGFR);
plfr_lm_15 = fitlm(grdata(grdata.SubjectID==SID(15)  & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(15)  & grdata.Texture == 'C1',:).PGFR);

f4 = figure(4);
hold on
sgtitle('Peak Grip Force Rate (N/s) vs. Weight (Linear Relationship)')

subplot(3,5,1)
hold on
A4 = scatter(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).PGFR,'*r','DisplayName','PGFR');
B4 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,plfr_lm_1.Coefficients.Estimate(1)+plfr_lm_1.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2,'DisplayName','OLS-model');
C4 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(1))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(1))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(1) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2,'DisplayName','LME-model');
hold off

subplot(3,5,2)
hold on
scatter(grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight,plfr_lm_2.Coefficients.Estimate(1)+plfr_lm_2.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(2))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(2))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(2) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,3)
hold on
scatter(grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight,plfr_lm_3.Coefficients.Estimate(1)+plfr_lm_3.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(3))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(3))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(3) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,4)
hold on
scatter(grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight,plfr_lm_4.Coefficients.Estimate(1)+plfr_lm_4.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(4))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(4))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(4) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,5)
hold on
scatter(grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight,plfr_lm_5.Coefficients.Estimate(1)+plfr_lm_5.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(5))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(5))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(5) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,6)
hold on
scatter(grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight,plfr_lm_6.Coefficients.Estimate(1)+plfr_lm_6.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(6))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(6))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(6) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,7)
hold on
scatter(grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight,plfr_lm_7.Coefficients.Estimate(1)+plfr_lm_7.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(7))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(7))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(7) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,8)
hold on
scatter(grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight,plfr_lm_8.Coefficients.Estimate(1)+plfr_lm_8.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(8))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(8))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(8) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,9)
hold on
scatter(grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight,plfr_lm_9.Coefficients.Estimate(1)+plfr_lm_9.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(9))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(9))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(9) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,10)
hold on
scatter(grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight,plfr_lm_10.Coefficients.Estimate(1)+plfr_lm_10.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(10))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(10))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(10) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,11)
hold on
scatter(grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight,plfr_lm_11.Coefficients.Estimate(1)+plfr_lm_11.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(11))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(11))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(11) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,12)
hold on
scatter(grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight,plfr_lm_12.Coefficients.Estimate(1)+plfr_lm_12.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(2))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(12))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(12) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,13)
hold on
scatter(grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight,plfr_lm_13.Coefficients.Estimate(1)+plfr_lm_13.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(13))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(13))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(13) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,14)
hold on
scatter(grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight,plfr_lm_14.Coefficients.Estimate(1)+plfr_lm_14.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(14))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(14))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(14) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

subplot(3,5,15)
hold on
scatter(grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight,grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight,plfr_lm_15.Coefficients.Estimate(1)+plfr_lm_15.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weight,fe(1)+re.Estimate(re.Level == num2str(SIDnum(15))&re.Name == '(Intercept)')+(fe(2)+re.Estimate(re.Level == num2str(SIDnum(15))&re.Name == 'Weightcentered'))*grdata(grdata.SubjectID==SID(15) & grdata.Texture == 'C1',:).Weightcentered,'-k','LineWidth',2)
hold off

han4 = axes(f4,'visible','off');
han4.XLabel.Visible = 'on';
han4.YLabel.Visible = 'on';
xlabel(han4,'Object mass (grams)','FontSize',20);
ylabel(han4,'PGFR: Peak Grip Force Rate (N/s)','FontSize',20);
lgd4 = legend([A4,B4,C4],'FontSize',20);
% set(lgd2,'MarkerSize',20);
lgd4.Orientation = 'horizontal';



%% Model comparisons and R^2 values

PLFR_loglinear_Rsquared = [lplfr_lme1_loglinear.Rsquared.Ordinary;lplfr_lme2_loglinear.Rsquared.Ordinary;lplfr_lme3_loglinear.Rsquared.Ordinary;lplfr_lme4_loglinear.Rsquared.Ordinary]
PLFR_linear_Rsquared = [plfr_lme1_linear.Rsquared.Ordinary;plfr_lme2_linear.Rsquared.Ordinary;plfr_lme3_linear.Rsquared.Ordinary;plfr_lme4_linear.Rsquared.Ordinary]
PGFR_loglinear_Rsquared = [lpgfr_lme1_loglinear.Rsquared.Ordinary;lpgfr_lme2_loglinear.Rsquared.Ordinary;lpgfr_lme3_loglinear.Rsquared.Ordinary;lpgfr_lme4_loglinear.Rsquared.Ordinary]
PGFR_linear_Rsquared = [pgfr_lme1_linear.Rsquared.Ordinary;pgfr_lme2_linear.Rsquared.Ordinary;pgfr_lme3_linear.Rsquared.Ordinary;pgfr_lme4_linear.Rsquared.Ordinary]
    
comp_plfr_linear_vs_loglinear = compare(plfr_lme3_linear,lplfr_lme3_loglinear)
comp_pgfr_linear_vs_loglinear = compare(pgfr_lme3_linear,lpgfr_lme3_loglinear)

