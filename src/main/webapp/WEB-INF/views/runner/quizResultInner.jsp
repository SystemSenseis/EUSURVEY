<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="esapi" uri="http://www.owasp.org/index.php/Category:OWASP_Enterprise_Security_API" %>
	
	<c:choose>
		<c:when test="${forpdf == null && responsive == null}">
			<div class="fullpageform">
		</c:when>
		<c:when test="${responsive != null}">
			<div style="margin-top: 40px;">
		</c:when>
		<c:otherwise>
			<div>
		</c:otherwise>
	</c:choose>
	
		<div class="quizresultsdiv">
			<img src="${contextpath}/resources/images/logo_Eusurvey.png" style="width: 200px" /><br />
		
			<div class="surveytitle">${form.survey.title} - <spring:message code="label.Results" /></div><br />
			<div style="margin-bottom: 20px;">${form.survey.quizResultsMessage}</div>
			
			<c:if test="${forpdf == null}">
				<div style="text-align: center; margin-bottom: 20px;">
					<a id="pdfDownloadButtonThanksInner" onclick="showExportDialogAndFocusEmail()" class="btn btn-default">${form.getMessage("label.GetPDF")}</a>		
				</div>
			</c:if>
			
			<c:if test="${form.survey.showTotalScore}">
		
				<div style="font-size: 20px; text-decoration: underline;"><spring:message code="label.Summary" /></div>
			
				<div style="float: right; width: 130px; height: 130px; margin-top: 0px;">
					
				</div>
				
				<table class="scoretable" style="margin-left: 30px;">
					<tr style="font-size: 130%;">
						<td style="padding: 15px; color: #337ab7;"><b><spring:message code="label.YourScore" /></b></td>
						<td style="padding: 15px; color: #337ab7;">${quiz.score}</td>
						<td rowspan="2" style="padding-left: 50px;">
							<img style="margin-top: -18px" src="${contextpath}/graphics/pie.png?v=${quiz.score}&amp;m=${quiz.maximumScore}" />
						</td>
					</tr>
					<tr>
						<td style="padding: 15px; padding-top: 10px; border: 0px;"><b><spring:message code="label.MaximumScore" /></b></td>
						<td style="padding: 15px; padding-top: 10px; border: 0px;">${quiz.maximumScore}</td>
					</tr>
				</table>			
			
				<c:if test="${form.survey.scoresByQuestion}">
				
					<c:if test="${form.survey.hasSections()}">
					<div style="margin-top: 20px; margin-bottom: 30px;">
						<table class="quizsectionresults" <c:if test="${ismobile == null}">style="width: 500px;"</c:if>>
							<tr>
								<th><spring:message code="form.Section" /></th>
								<th colspan="2"><spring:message code="label.ScoreForThisSection" /></th>
							</tr>
								<c:forEach var="page" items="${form.getPages()}" varStatus="rowCounter">
				 					<c:forEach var="element" items="${page}">
				 						<c:if test="${element.getType() == 'Section'}">
					 						<c:if test='${!quiz.getSectionScore(element.uniqueId).equals("0/0")}'>		
												<tr>
													<td style="width: 225px">${element.getTitle()}</td>
													<td style="width: 50px">${quiz.getSectionScoreValue(element.uniqueId)}</td>
													<td style="width: 225px">												
														<c:set var="scoring" value="${quiz.getSectionScore(element.uniqueId)}" />
														
														<div class="progress noprogressbackground" style="width: 200px; margin-bottom: 2px;">
														  <div class="progress-bar" style="width: ${quiz.getSectionScoreValue(element.uniqueId) / quiz.getMaxSectionScore() * 100}%;"></div>
														</div>
													</td>
												</tr>
											</c:if>
										</c:if>
									</c:forEach>
								</c:forEach>								
						</table>
					</div>
					</c:if>				
				
					<div style="font-size: 20px; text-decoration: underline;"><spring:message code="label.ScoresByQuestion" /></div>
					
					<table style="margin-top: 20px; margin-bottom: 20px; table-layout:fixed; max-width: 100%">
						<c:forEach var="page" items="${form.getPages()}" varStatus="rowCounter">
				 			<c:forEach var="element" items="${page}">
				 				<c:choose>
				 					<c:when test="${invisibleElements != null && invisibleElements.contains(element.uniqueId)}">
				 					
				 					</c:when>		 				
				 					<c:when test="${element.getType() == 'Section'}">
				 						<c:set var="scoring" value="${quiz.getSectionScore(element.uniqueId)}" />
						 				<c:if test='${!scoring.equals("0/0")}'>		
					 						<tr>
					 							<td colspan="4" style="padding-top: 20px">
					 								<div class="sectiontitle section${element.getLevel()}">
					 									<c:if test="${scoring != null}">
						 									<div style="float: right; font-size: 14px">
						 										<spring:message code="label.ScoreForThisSection" />: ${scoring}
						 									</div>
						 								</c:if>
					 									${element.getTitle()}
					 								</div>
					 							</td>
					 						</tr>
				 						</c:if>
				 					</c:when>
				 					<c:when test="${element.getType() == 'SingleChoiceQuestion' || element.getType() == 'MultipleChoiceQuestion' || element.getType() == 'FreeTextQuestion' || element.getType() == 'NumberQuestion' || element.getType() == 'DateQuestion'}">
						 				<c:if test="${element.scoring > 0}">
						 					<tr>
						 						<td colspan="4" style="padding-top: 20px">
					 								<c:choose>
														<c:when test="${forpdf != null || element.getStrippedTitleNoEscape().length() < 200}">
															<div class="quizquestion">${element.getStrippedTitleNoEscape()}</div>
														</c:when>
														<c:otherwise>
															<div class="quizquestion">
																<div class="fullcontent hideme">${element.getStrippedTitle()}<a class='lessbutton' onclick='switchQuestionTitle(this);'><spring:message code="label.less" /></a>	
																</div>
																<div class='shortcontent'>${element.getStrippedTitle().substring(0,190)}<a class="morebutton" onclick="switchQuestionTitle(this);"><spring:message code="label.more" /></a>
																</div>
															</div>
														</c:otherwise>
													</c:choose>			 							
						 						</td>
						 					</tr>				 				
								 				
						 					<c:set var="answers" value="${form.answerSets[0].getAnswers(element.id, element.uniqueId)}" />
						 					
						 					<tr class="scorerow">
								 				<td><spring:message code="label.YourAnswer" /></td>
						 						<td>
						 							<c:choose>
							 							<c:when test="${element.getType() == 'SingleChoiceQuestion' || element.getType() == 'MultipleChoiceQuestion'}">
							 								<c:forEach items="${answers}" var="answer">	
							 									<div class="quizanswer">
								 									<c:set var="pa" value="${element.getPossibleAnswerByUniqueId(answer.possibleAnswerUniqueId)}" />
								 									<c:choose>
								 										<c:when test="${!form.survey.showQuizIcons}">
								 										
								 										</c:when>
								 										<c:when test="${forpdf != null && pa.scoring.correct}">
								 											<img style="width: 20px;vertical-align: text-top;" src="${contextpath}/resources/images/correct.png" />
								 										</c:when>
								 										<c:when test="${pa.scoring.correct}">
								 											<span class="glyphicon glyphicon-ok" style="color: #0f0"></span>
								 										</c:when>
								 										<c:when test="${forpdf != null}">
								 											<img style="width: 20px;vertical-align: text-top;" src="${contextpath}/resources/images/incorrect.png" />
								 										</c:when>
								 										<c:otherwise>
								 											<span class="glyphicon glyphicon-remove" style="color: #f00"></span>
								 										</c:otherwise>
								 									</c:choose>
								 									
																	${form.getAnswerTitle(answer)}
																	<div class="quizfeedback">${pa.scoring.feedback}</div>
																</div>
															</c:forEach>		
															
															<c:if test="${element.getType() == 'MultipleChoiceQuestion' && quiz.getPartiallyAnswersMultipleChoiceQuestions().contains(element.getUniqueId())}">
							 									<div class="quizanswer">
							 										<c:choose>
							 											<c:when test="${!form.survey.showQuizIcons}">
								 										
								 										</c:when>
							 											<c:when test="${forpdf != null}">
								 											<img style="width: 20px;vertical-align: text-top;" src="${contextpath}/resources/images/incorrect.png" />
								 										</c:when>
								 										<c:otherwise>
								 											<span class="glyphicon glyphicon-remove" style="color: #f00"></span>
								 										</c:otherwise>
							 										</c:choose>
							 										
							 										<spring:message code="info.NotAllCorrectAnswers" />
							 									</div>
							 								</c:if> 							
							 							</c:when>
							 							<c:otherwise>
							 								<c:if test="${answers == null || answers.size() == 0}">
							 									<c:set var="scoring" value="${quiz.getQuestionScoringItem(element.uniqueId)}" />
						 										<c:if test="${scoring != null}">
						 											<div class="quizanswer">
						 												<c:choose>
						 													<c:when test="${!form.survey.showQuizIcons}">
								 										
								 											</c:when>
									 										<c:when test="${forpdf != null && scoring.correct}">
									 											<img style="width: 20px;vertical-align: text-top;" src="${contextpath}/resources/images/correct.png" />
									 										</c:when>
									 										<c:when test="${scoring.correct}">
									 											<span class="glyphicon glyphicon-ok" style="color: #0f0"></span>
									 										</c:when>
									 										<c:when test="${forpdf != null}">
									 											<img style="width: 20px;vertical-align: text-top;" src="${contextpath}/resources/images/incorrect.png" />
									 										</c:when>
									 										<c:otherwise>
									 											<span class="glyphicon glyphicon-remove" style="color: #f00"></span>
									 										</c:otherwise>
									 									</c:choose>
																		<spring:message code="label.emptyAnswer" />
																		<div class="quizfeedback">${scoring.feedback}</div>
						 											</div>
						 										</c:if>
							 								</c:if>
							 								<c:forEach items="${answers}" var="answer">	
							 									<div class="quizanswer">
							 										<c:set var="scoring" value="${quiz.getQuestionScoringItem(element.uniqueId)}" />
							 										<c:if test="${scoring != null}">
								 										<c:choose>
								 											<c:when test="${!form.survey.showQuizIcons}">
								 										
								 											</c:when>
									 										<c:when test="${forpdf != null && scoring.correct}">
									 											<img style="width: 20px;vertical-align: text-top;" src="${contextpath}/resources/images/correct.png" />
									 										</c:when>
									 										<c:when test="${scoring.correct}">
									 											<span class="glyphicon glyphicon-ok" style="color: #0f0"></span>
									 										</c:when>
									 										<c:when test="${forpdf != null}">
									 											<img style="width: 20px;vertical-align: text-top;" src="${contextpath}/resources/images/incorrect.png" />
									 										</c:when>
									 										<c:otherwise>
									 											<span class="glyphicon glyphicon-remove" style="color: #f00"></span>
									 										</c:otherwise>
									 									</c:choose>
																		${form.getAnswerTitle(answer)}
																		<div class="quizfeedback">${scoring.feedback}</div>
																	</c:if>
																	<c:if test="${scoring == null && forpdf == null}">
																		<c:if test="${form.survey.showQuizIcons}">
																		<span class="glyphicon glyphicon-remove" style="color: #f00"></span>
																		</c:if>
									 									${form.getAnswerTitle(answer)}
																	</c:if>
																	<c:if test="${scoring == null && forpdf != null}">
																		<img style="width: 20px;vertical-align: text-top;" src="${contextpath}/resources/images/incorrect.png" />
									 									${form.getAnswerTitle(answer)}
																	</c:if>
							 									</div>
							 								</c:forEach>
							 							</c:otherwise>
						 							</c:choose>
						 						</td>
						 						<td class="score">${quiz.getQuestionScore(element.uniqueId)}&#x20;<spring:message code="label.outOf" />&#x20;${quiz.getQuestionMaximumScore(element.uniqueId)}&#x20;<spring:message code="label.points" /></td>
						 						<td>
						 							<div class="progress hidden-xs hidden-md" style="width: 200px; margin-bottom: 2px;">
													  <div class="chartRequestedRecordsPercent progress-bar" style="width: ${quiz.getQuestionScore(element.uniqueId) / quiz.getQuestionMaximumScore(element.uniqueId) * 100}%;"></div>
													</div>
						 						</td>
								 			</tr>
						 					<c:if test="${forpdf == null}">
							 					<tr class="visible-xs visible-md">
							 						<td colspan="3">
							 							<div class="progress" style="width: 200px; margin-bottom: 2px;">
														  <div class="chartRequestedRecordsPercent progress-bar" style="width: ${quiz.getQuestionScore(element.uniqueId) / quiz.getQuestionMaximumScore(element.uniqueId) * 100}%;"></div>
														</div>
							 						</td>
							 					</tr>
							 				</c:if>
									</c:if>
						 	</c:when>
				 		</c:choose>
				 	</c:forEach>
				 </c:forEach>
			</table>
				</c:if>
			</c:if>
			
			<hr />
			<table style="margin-left: 20px;">
				<tr>
					<td style="padding-right: 10px"><spring:message code="label.Contact" /></td>
					<td>
						<c:choose>
							<c:when test="${form.survey.contact.contains('@')}">
								<i class="icon icon-envelope" style="vertical-align: middle"></i>
								<a class="link" href="mailto:<esapi:encodeForHTMLAttribute>${form.survey.contact}</esapi:encodeForHTMLAttribute>"><esapi:encodeForHTML>${form.survey.contact}</esapi:encodeForHTML></a>
							</c:when>
							<c:otherwise>
								<i class="icon icon-globe" style="vertical-align: middle"></i>
								<a target="_blank" class="link visiblelink" href="<esapi:encodeForHTMLAttribute>${form.survey.fixedContact}</esapi:encodeForHTMLAttribute>"><esapi:encodeForHTML>${form.survey.fixedContactLabel}</esapi:encodeForHTML></a>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				
				<c:if test="${form.survey.getUsefulLinks().size() != 0}">	
					<tr>
						<td style="padding-right: 10px"><spring:message code="label.UsefulLinks" /></td>				
						<td>					
							<c:forEach var="link" items="${form.survey.getAdvancedUsefulLinks()}">
								<div style="margin-top: 5px;" ><a class="link visiblelink" target="_blank" rel="noopener noreferrer" href="<esapi:encodeForHTMLAttribute>${link.value}</esapi:encodeForHTMLAttribute>">${link.key}</a></div>
							</c:forEach>							
						</td>
					</tr>
				</c:if>
				
				<c:if test="${form.survey.getBackgroundDocuments().size() != 0}">
					<tr>
						<td style="padding-right: 10px"><spring:message code="label.BackgroundDocuments" /></td>	
						<td>
							<c:forEach var="link" items="${form.survey.getBackgroundDocumentsAlphabetical()}">
								<div style="margin-top: 5px;" ><a class="link visiblelink" target="_blank" href="<esapi:encodeForHTMLAttribute>${link.value}</esapi:encodeForHTMLAttribute>">${link.key}</a></div>
							</c:forEach>							
						</td>
					</tr>
				</c:if>	
				
				<tr>
					<td style="padding-right: 10px; padding-top: 10px;"><spring:message code="label.ContributionId" /></td>
					<td style="padding-top: 10px;">${form.answerSets[0].uniqueCode}</td>
				</tr>
				<tr>
					<td style="padding-right: 10px"><spring:message code="label.CompletedAt" /></td>
					<td>${form.answerSets[0].niceDate}</td>
				</tr>
				
			</table>			
			
		</div>
		
		<c:if test="${forpdf == null}">
			<div style="text-align: center; margin-bottom: 20px;">
				<a id="pdfDownloadButtonThanksInner" onclick="showExportDialogAndFocusEmail()" class="btn btn-default">${form.getMessage("label.GetPDF")}</a>		
			</div>
		</c:if>
	</div>
	
	<c:if test="${forpdf == null}">
	
	<div class="modal fade" id="ask-export-dialog" data-backdrop="static">	
			<div class="modal-dialog">
		    <div class="modal-content">
			<div class="modal-header">
				<b><spring:message code="label.Info" /></b>
			</div>
			<div class="modal-body">
				<p>
					<c:choose>
						<c:when test="${runnermode == true}">
							${form.getMessage("question.EmailForPDF")}
						</c:when>
						<c:otherwise>
							<spring:message code="question.EmailForPDF" />
						</c:otherwise>	
					</c:choose>
				</p>
				<input type="text" maxlength="255" name="email" id="email" />
				<span id="ask-export-dialog-error" class="validation-error hideme">
					<c:choose>
						<c:when test="${runnermode == true}">
							${form.getMessage("message.ProvideEmail")}
						</c:when>
						<c:otherwise>
							<spring:message code="message.ProvideEmail" />
						</c:otherwise>	
					</c:choose>
				</span>
				<div class="captcha" style="margin-left: 0px; margin-bottom: 20px; margin-top: 20px;">						
					<c:if test="${captchaBypass !=true}">
					<%@ include file="../captcha.jsp" %>					
					</c:if>
		       	</div>
		       	<span id="ask-export-dialog-error-captcha" class="validation-error hideme">       		
		       		<c:if test="${captchaBypass !=true}">
		       		<c:choose>
						<c:when test="${runnermode == true}">
							${form.getMessage("message.captchawrongnew")}
						</c:when>
						<c:otherwise>
							<spring:message code="message.captchawrongnew" />
						</c:otherwise>	
					</c:choose>
		       		</c:if>
		       	</span>
			</div>
			<div class="modal-footer">
				<c:choose>
					<c:when test="${responsive != null}">
						<a style="text-decoration: none"  class="btn btn-info btn-lg" onclick="startExport()">${form.getMessage("label.OK")}</a>	
						<a style="text-decoration: none"  class="btn btn-default btn-lg" data-dismiss="modal">${form.getMessage("label.Cancel")}</a>		
					</c:when>
					<c:when test="${runnermode == true}">
						<a  class="btn btn-info" onclick="startExport()">${form.getMessage("label.OK")}</a>	
						<a  class="btn btn-default" data-dismiss="modal">${form.getMessage("label.Cancel")}</a>		
					</c:when>
					<c:otherwise>
						<a  class="btn btn-info" onclick="startExport()"><spring:message code="label.OK" /></a>	
						<a  class="btn btn-default" data-dismiss="modal"><spring:message code="label.Cancel" /></a>		
					</c:otherwise>	
				</c:choose>				
			</div>
			</div>
			</div>
		</div>
		
		<script type="text/javascript">
			
			function switchQuestionTitle(a)
			{
				var div = $(a).closest(".quizquestion");
				var text = $(div).find(".fullcontent").html().replace("&nbsp;", " ");
				
				if ($(a).hasClass("morebutton"))
				{
					$(div).find(".shortcontent").hide();
					$(div).find(".fullcontent").show();
				} else {
					$(div).find(".shortcontent").show();
					$(div).find(".fullcontent").hide();
				}
			}
		
			function startExport()
			{
				$("#ask-export-dialog").find(".validation-error").hide();
				
				var mail = $("#email").val();
				if (mail.trim().length == 0 || !validateEmail(mail))
				{
					$("#ask-export-dialog-error").show();
					return;
				};	
						
				<c:choose>
					<c:when test="${!captchaBypass}">
						var challenge = getChallenge();
					    var uresponse = getResponse();
					
						$.ajax({
							type:'GET',
							  url: "${contextpath}/runner/createquizpdf/${uniqueCode}",
							  data: {email : mail, recaptcha_challenge_field : challenge, 'g-recaptcha-response' : uresponse},
							  cache: false,
							  success: function( data ) {
								  
								  if (data == "success") {
										$('#ask-export-dialog').modal('hide');
										showInfo(message_PublicationExportSuccess2.replace('{0}', mail));
								  	} else if (data == "errorcaptcha") {
								  		$("#ask-export-dialog-error-captcha").show();
								  		reloadCaptcha();
									} else {
										showError(message_PublicationExportFailed);
										reloadCaptcha();
									};
							}
						});							
					</c:when>
					<c:otherwise>			
						$.ajax({				
							type:'GET',
							  url: "${contextpath}/runner/createquizpdf/${uniqueCode}",
							  data: {email : mail, recaptcha_challenge_field : '', 'g-recaptcha-response' : ''},
							  cache: false,
							  success: function( data ) {
								  
								  if (data == "success") {
										$('#ask-export-dialog').modal('hide');
										showInfo(message_PublicationExportSuccess2.replace('{0}', mail));
									} else {
										showError(message_PublicationExportFailed);
										reloadCaptcha();
									};
							}
						});							
					</c:otherwise>
				</c:choose>
			}
		</script>
		
		</c:if>