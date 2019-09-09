<script type="text/javascript">
	var surveyUniqueId = "${form.survey.uniqueId}";
</script>

<div style="display: none">

	<div id="section-template">
		<div data-bind="html: title, attr: {'data-level': level, 'class':'sectiontitle section' + level()}"></div>
		<!-- ko if: foreditor -->
			<input type="hidden" data-bind="value: 'section', attr: {'name': 'type' + id()}" />	
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />	
			<input type="hidden" data-bind="value: tabTitle, attr: {'name': 'tabtitle' + id()}" />	
			<input type="hidden" data-bind="value: level, attr: {'name': 'level' + id()}" />	
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
		<!-- /ko -->
	</div>
	
	<div id="text-template">
		<div class="text" data-bind="html: title"></div>
		<!-- ko if: foreditor -->
			<input type="hidden" data-bind="value: 'text', attr: {'name': 'type' + id()}" />	
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />	
			<input type="hidden" data-bind="value: true, attr: {'name': 'optional' + id()}" />
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
		<!-- /ko -->
	</div>
	
	<div id="image-template">
		
		<div class='alignment-div' data-bind="attr: {'style': 'width: 920px; max-width: 100%; text-align:' + align()}">
			<img style="max-width: 100%" data-bind="attr: {'src': url, 'alt': originalTitle, 'width': usedwidth() > 0 ? usedwidth() : ''}" />
		</div>
		
		<!-- ko if: foreditor -->
			<input type="hidden" data-bind="value: 'image', attr: {'name': 'type' + id()}" />	
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />	
			<input type="hidden" data-bind="value: title, attr: {'name': 'name' + id()}" />	
			<input type="hidden" data-bind="value: scale, attr: {'name': 'scale' + id()}" />	
			<input type="hidden" data-bind="value: width, attr: {'name': 'width' + id()}" />	
			<input type="hidden" data-bind="value: align, attr: {'name': 'align' + id()}" />	
			<input type="hidden" data-bind="value: url, attr: {'name': 'url' + id()}" />	
			<input type="hidden" data-bind="value: filename, attr: {'name': 'filename' + id()}" />	
			<input type="hidden" data-bind="value: longdesc, attr: {'name': 'longdesc' + id()}" />	
			<input type="hidden" data-bind="value: true, attr: {'name': 'optional' + id()}" />
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
		<!-- /ko -->
	</div>

	<div id="ruler-template">
		<hr data-bind="attr: {'style': 'border-top: ' + height() + 'px ' + style() + ' ' + color() }" />
		<!-- ko if: foreditor -->
			<input type="hidden" data-bind="value: 'ruler', attr: {'name': 'type' + id()}" />	
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />	
			<input type="hidden" data-bind="value: true, attr: {'name': 'optional' + id()}" />
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
			<input type="hidden" data-bind="value: color, attr: {'name': 'color' + id()}" />
			<input type="hidden" data-bind="value: height, attr: {'name': 'height' + id()}" />
			<input type="hidden" data-bind="value: style, attr: {'name': 'style' + id()}" />			
		<!-- /ko -->
	</div>

	<div id="single-choice-template">
		<!-- ko if: optional() == false -->
			<span class="mandatory" style="position: absolute; margin-left: -7px; margin-top: 2px;">*</span>
		<!-- /ko -->
		<label class='questiontitle' data-bind='html: title, attr: {for: "answer" + id()}'></label>
		<div class='questionhelp' data-bind="html: niceHelp"></div>
		<div class="answer-columns">
			<!-- ko if: useRadioButtons -->
			<table class="answers-table">
				<tr class="hideme">
					<th>radio button</th>
					<th>label</th>
				</tr>
				
				<!-- ko if: foreditor -->
				<tr class="hideme">
					<td>
					<!-- ko foreach: possibleAnswers() -->
							<input type="hidden" data-bind="value: dependentElementsString(), attr: {'name': 'dependencies' + $parent.id(), 'data-id' : id()}" />	
							<input type="hidden" data-bind="value: shortname, attr: {'name': 'pashortname' + $parent.id(), 'data-id' : id()}" />	
							<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'pauid' + $parent.id(), 'data-id' : id()}" />	
							<textarea style="display: none" data-bind="text: title, attr: {'name': 'answer' + $parent.id(), 'data-id' : id()}"></textarea>					
							<input type="hidden" data-bind="value: scoring.correct, attr: {'name': 'correct' + $parent.id(), 'data-id' : id()}" />	
							<input type="hidden" data-bind="value: scoring.points, attr: {'name': 'answerpoints' + $parent.id(), 'data-id' : id()}" />	
							<input type="hidden" data-bind="value: scoring.feedback, attr: {'name': 'feedback' + $parent.id(), 'data-id' : id()}" />						
					<!-- /ko -->
					</td>					
				</tr>
				<!-- /ko -->				
				
				<!-- ko foreach: orderedPossibleAnswersByRows(${ismobile != null}, ${responsive != null}) -->
				<tr class="possibleanswerrow">				
					<!-- ko foreach: $data -->					
										
					<td style="vertical-align: top">
						<!-- ko ifnot: id() == 'dummy' -->
						<input data-bind="enable: !$parents[1].readonly() && !$parents[1].foreditor, checked: getPAByQuestion2($parents[1].uniqueId(), uniqueId(), id()), attr: {'data-id': $parents[1].id() + '' + id(), 'id': id(), 'data-shortname': shortname(), 'data-dependencies': dependentElementsString(), onclick: $parents[1].readonly() ? 'return false;' : 'singleClick(this); checkDependenciesAsync(this);', class: $parents[1].css + ' trigger check', name: 'answer' + $parents[1].id(), value: id()}" type="radio"  />
						<!-- /ko -->	
					</td>
					<td style="padding-right: 15px; vertical-align: top">
						<label data-bind="attr: {'for': id}">
							<!-- ko ifnot: id() == 'dummy' -->
							<div class="answertext" data-bind="html: title, attr: {'data-id' : id()}"></div>
							<!-- /ko -->	
						</label>
					</td>					
				
					<!-- /ko -->
				</tr>
				<!-- /ko -->
			</table>
			<!-- /ko -->
			<!-- ko ifnot: useRadioButtons -->
			<div class="answer-column">		
				<select data-bind="foreach: orderedPossibleAnswers(false), enable: !readonly(), valueAllowUnset: true, value: getPAByQuestion3(uniqueId()), attr: {'id': 'answer' + id(), 'data-id':id(), 'data-shortname': shortname(), 'name' : 'answer' + id(), 'class': css + ' single-choice'}"  onchange="validateInput($(this).parent(),true); checkDependenciesAsync(this); propagateChange();">
					<option data-bind="html: strip_tags(title()), attr: {value: id(), 'data-dependencies': dependentElementsString(), 'id': 'trigger'+id()}" class="possible-answer trigger"></option>
				</select>
				<span data-bind="if: readonly"><input data-bind="value: getPAByQuestion3(uniqueId()), attr: {'name':'answer'+id}" type="hidden" /></span>	
				<!-- ko if: foreditor -->
					<!-- ko foreach: possibleAnswers() -->
						<div class="possibleanswerrow hidden">		
							<input type="hidden" data-bind="value: dependentElementsString(), attr: {'name': 'dependencies' + $parents[0].id(), 'data-id' : id()}" />	
							<input type="hidden" data-bind="value: shortname, attr: {'name': 'pashortname' + $parents[0].id(), 'data-id' : id()}" />	
							<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'pauid' + $parents[0].id(), 'data-id' : id()}" />	
							<textarea style="display: none" data-bind="text: title, attr: {'name': 'answer' + $parents[0].id(), 'data-id' : id()}"></textarea>
							<div class="answertext" data-bind="html: title, attr: {'id' : id(), 'data-id' : id()}"></div>
							<input type="hidden" data-bind="value: scoring.correct, attr: {'name': 'correct' + $parents[0].id(), 'data-id' : id()}" />	
							<input type="hidden" data-bind="value: scoring.points, attr: {'name': 'answerpoints' + $parents[0].id(), 'data-id' : id()}" />	
							<input type="hidden" data-bind="value: scoring.feedback, attr: {'name': 'feedback' + $parents[0].id(), 'data-id' : id()}" />	
						</div>
					<!-- /ko -->
				<!-- /ko -->					
			</div>
			<!-- /ko -->
			
			<input type="hidden" data-bind="value: choiceType, attr: {'name': 'choicetype' + id()}" />
			
			<!-- ko if: foreditor -->
				<input type="hidden" data-bind="value: 'choice', attr: {'name': 'type' + id()}" />
				<input type="hidden" data-bind="value: 'true', attr: {'name': 'single' + id()}" />	
				<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />
				<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
				<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />	
				<input type="hidden" data-bind="value: order, attr: {'name': 'order' + id()}" />	
				<input type="hidden" data-bind="value: readonly, attr: {'name': 'readonly' + id()}" />	
				<input type="hidden" data-bind="value: isAttribute, attr: {'name': 'attribute' + id()}" />	
				<input type="hidden" data-bind="value: attributeName, attr: {'name': 'nameattribute' + id()}" />	
				<input type="hidden" data-bind="value: numColumns, attr: {'name': 'columns' + id()}" />
				<input type="hidden" data-bind="value: useRadioButtons ? 'radio' : 'select', attr: {'name': 'choicetype' + id()}" />
				<input type="hidden" data-bind="value: 0, attr: {'name': 'choicemin' + id()}" />
				<input type="hidden" data-bind="value: 0, attr: {'name': 'choicemax' + id()}" />	
				<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
				<textarea style="display: none" data-bind="text: help, attr: {'name': 'help' + id()}"></textarea>
		
				<input type="hidden" data-bind="value: scoring, attr: {'name': 'scoring' + id()}" />
				<input type="hidden" data-bind="value: points, attr: {'name': 'points' + id()}" />
			<!-- /ko -->		
		</div>
	</div>
		
	<div id="multiple-choice-template">
		<!-- ko if: optional() == false -->
			<span class="mandatory" style="position: absolute; margin-left: -7px; margin-top: 2px;">*</span>
		<!-- /ko -->
		<label class='questiontitle' data-bind='html: title, attr: {for: "answer" + id()}'></label>
		
		<!-- ko if: minChoices() != 0 && maxChoices() != 0 -->
			<div class='limits' data-bind="html: getMinMaxChoice(minChoices(), maxChoices())"></div>
		<!-- /ko -->
		<!-- ko if: minChoices() != 0 && maxChoices() == 0 -->
			<div class='limits' data-bind="html: getMinChoice(minChoices())"></div>
		<!-- /ko -->
		<!-- ko if: minChoices() == 0 && maxChoices() != 0 -->
			<div class='limits' data-bind="html: getMaxChoice(maxChoices())"></div>
		<!-- /ko -->
		
		<div class='questionhelp' data-bind="html: niceHelp"></div>
		<div class="answer-columns">
			<!-- ko if: useCheckboxes -->
			<table class="answers-table">
				<tr class="hideme">
					<th>checkbox</th>
					<th>label</th>
				</tr>
				
				<!-- ko if: foreditor -->
				<tr class="hideme">
					<td>
					<!-- ko foreach: possibleAnswers() -->
							<input type="hidden" data-bind="value: dependentElementsString(), attr: {'name': 'dependencies' + $parent.id(), 'data-id' : id()}" />	
							<input type="hidden" data-bind="value: shortname, attr: {'name': 'pashortname' + $parent.id(), 'data-id' : id()}" />	
							<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'pauid' + $parent.id(), 'data-id' : id()}" />	
							<textarea style="display: none" data-bind="text: title, attr: {'name': 'answer' + $parent.id(), 'data-id' : id()}"></textarea>					
							<input type="hidden" data-bind="value: scoring.correct, attr: {'name': 'correct' + $parent.id(), 'data-id' : id()}" />	
							<input type="hidden" data-bind="value: scoring.points, attr: {'name': 'answerpoints' + $parent.id(), 'data-id' : id()}" />	
							<input type="hidden" data-bind="value: scoring.feedback, attr: {'name': 'feedback' + $parent.id(), 'data-id' : id()}" />						
					<!-- /ko -->
					</td>					
				</tr>
				<!-- /ko -->	
				
				<!-- ko foreach: orderedPossibleAnswersByRows(${ismobile != null}, ${responsive != null}) -->
				<tr class="possibleanswerrow">					
					<!-- ko foreach: $data -->
					<td style="vertical-align: top">
						<!-- ko ifnot: id() == 'dummy' -->
						<input data-bind="enable: !$parents[1].readonly() && !$parents[1].foreditor, checked: !$parents[1].foreditor && getPAByQuestion($parents[1].uniqueId()).indexOf(uniqueId()) > -1, attr: {'data-id': $parents[1].id() + '' + id(), 'id': id(), 'data-shortname': shortname(), 'data-dependencies': dependentElementsString(), onclick: $parents[1].readonly() ? 'return false;' : 'singleClick(this); checkDependenciesAsync(this);', class: $parents[1].css + ' trigger check', name: 'answer' + $parents[1].id(), value: id()}" type="checkbox"  />
						<!-- /ko -->
					</td>
					<td style="padding-right: 15px; vertical-align: top">
						<!-- ko ifnot: id() == 'dummy' -->
						<label data-bind="attr: {'for': id}">
							<div class="answertext" data-bind="html: title, attr: {'data-id' : id()}"></div>
						</label>
						<!-- /ko -->
					</td>	
					<!-- /ko -->
				</tr>		
				<!-- /ko -->	
			</table>
			<!-- /ko -->
			<!-- ko ifnot: useCheckboxes -->
			<div class="answer-column">													
				<ul data-bind="attr: {'class':css + ' multiple-choice'}, foreach: orderedPossibleAnswers()">
					<li data-bind="attr: { 'data-id': id(), 'class': 'possible-answer trigger ' + (getPAByQuestion($parent.uniqueId()).indexOf(uniqueId()) > -1 ? 'selected-choice' : '') , 'onclick' : $parent.readonly() || $parent.foreditor ? 'return false;' : 'selectMultipleChoiceAnswer($(this).children().first()); event.stopImmediatePropagation();'}">
						<a data-bind="attr: {'data-shortname': shortname(), 'onkeypress': $parent.readonly() || $parent.foreditor ? 'return false;' : 'returnTrueForSpace(event);selectMultipleChoiceAnswer(this);propagateChange();', 'onclick' : $parent.readonly() || $parent.foreditor ? 'return false;' : 'selectMultipleChoiceAnswer(this); event.stopImmediatePropagation();propagateChange();'}" >
							<span data-bind="html:  strip_tags(title()), attr: {'data-id' : id()}" class="answertext"></span>
						</a>
						<input data-bind="value: id(), checked: getPAByQuestion2($parent.uniqueId(), uniqueId(), id), attr: {'name': 'answer' + $parent.id(), 'id':id(), 'data-id': $parent.id() + id(), 'data-dependencies':dependentElementsString}" style="display: none" type="checkbox" />
					</li>	
				</ul>
				<!-- ko if: foreditor -->
					<!-- ko foreach: possibleAnswers() -->
					<div class="possibleanswerrow hidden">	
						<input type="hidden" data-bind="value: dependentElementsString(), attr: {'name': 'dependencies' + $parents[0].id(), 'data-id' : id()}" />	
						<input type="hidden" data-bind="value: shortname, attr: {'name': 'pashortname' + $parents[0].id(), 'data-id' : id()}" />	
						<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'pauid' + $parents[0].id(), 'data-id' : id()}" />	
						<textarea style="display: none" data-bind="text: title, attr: {'name': 'answer' + $parents[0].id(), 'data-id' : id()}"></textarea>
						<div class="answertext" data-bind="html: title, attr: {'id' : id(), 'data-id' : id()}"></div>
						<input type="hidden" data-bind="value: scoring.correct, attr: {'name': 'correct' + $parents[0].id(), 'data-id' : id()}" />	
						<input type="hidden" data-bind="value: scoring.points, attr: {'name': 'answerpoints' + $parents[0].id(), 'data-id' : id()}" />	
						<input type="hidden" data-bind="value: scoring.feedback, attr: {'name': 'feedback' + $parents[0].id(), 'data-id' : id()}" />	
					</div>
					<!-- /ko -->
				<!-- /ko -->		
			</div>
			<!-- /ko -->
		
			<input type="hidden" data-bind="value: choiceType, attr: {'name': 'choicetype' + id()}" />
			
			<!-- ko if: foreditor -->
				<input type="hidden" data-bind="value: 'choice', attr: {'name': 'type' + id()}" />	
				<input type="hidden" data-bind="value: 'false', attr: {'name': 'single' + id()}" />	
				<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />
				<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
				<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />	
				<input type="hidden" data-bind="value: order, attr: {'name': 'order' + id()}" />	
				<input type="hidden" data-bind="value: readonly, attr: {'name': 'readonly' + id()}" />	
				<input type="hidden" data-bind="value: isAttribute, attr: {'name': 'attribute' + id()}" />	
				<input type="hidden" data-bind="value: attributeName, attr: {'name': 'nameattribute' + id()}" />	
				<input type="hidden" data-bind="value: numColumns, attr: {'name': 'columns' + id()}" />
				<input type="hidden" data-bind="value: useCheckboxes ? 'checkbox' : 'list', attr: {'name': 'choicetype' + id()}" />
				<input type="hidden" data-bind="value: minChoices, attr: {'name': 'choicemin' + id()}" />
				<input type="hidden" data-bind="value: maxChoices, attr: {'name': 'choicemax' + id()}" />	
				<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
				<textarea style="display: none" data-bind="text: help, attr: {'name': 'help' + id()}"></textarea>
		
				<input type="hidden" data-bind="value: scoring, attr: {'name': 'scoring' + id()}" />
				<input type="hidden" data-bind="value: points, attr: {'name': 'points' + id()}" />
				<input type="hidden" data-bind="value: noNegativeScore, attr: {'name': 'noNegativeScore' + id()}" />
		
			<!-- /ko -->
		</div>
	</div>
	
	<div id="password-template">
		<!-- ko if: optional() == false -->
			<span class="mandatory" style="position: absolute; margin-left: -7px; margin-top: 2px;">*</span>
		<!-- /ko -->
		<label class='questiontitle' data-bind='html: title, attr: {for: "answer" + id()}'></label>
		<div class='questionhelp' data-bind="html: niceHelp"></div>
		<input data-bind="enable: !readonly(), value:getValueByQuestion(uniqueId()), attr: {'id': 'input' + id(), 'data-id':id(), 'data-shortname': shortname(), 'name' : 'answer' + id(), 'class':css()}" onfocus="clearStars(this);" onkeyup="countChar(this); propagateChange();" onblur="validateInput($(this).parent(), true)" autocomplete="off" type="password"></input>
		<!-- ko if: isComparable -->		
			<br /><span style="margin-left: 20px">${form.getMessage("label.PleaseRepeat")}</span>:<br />
			<input data-bind="enable: !readonly(), attr: {'id': 'answer' + id() + '2', 'data-id':id() + '2', 'name' : 'secondanswer' + id(), 'class': 'comparable-second ' + css()}" onfocus="clearStars(this);" autocomplete="off" type="password"></input>	
		<!-- /ko -->
		<!-- ko if: foreditor -->
			<input type="hidden" data-bind="value: 'freetext', attr: {'name': 'type' + id()}" />	
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />	
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />	
			<input type="hidden" data-bind="value: readonly, attr: {'name': 'readonly' + id()}" />	
			<input type="hidden" data-bind="value: isAttribute, attr: {'name': 'attribute' + id()}" />	
			<input type="hidden" data-bind="value: attributeName, attr: {'name': 'nameattribute' + id()}" />
			<input type="hidden" data-bind="value: numRows, attr: {'name': 'rows' + id()}" />
			<input type="hidden" data-bind="value: minCharacters, attr: {'name': 'min' + id()}" />
			<input type="hidden" data-bind="value: maxCharacters, attr: {'name': 'max' + id()}" />
			<input type="hidden" data-bind="value: isPassword, attr: {'name': 'password' + id()}" />
			<input type="hidden" data-bind="value: isUnique, attr: {'name': 'unique' + id()}" />
			<input type="hidden" data-bind="value: isComparable, attr: {'name': 'comparable' + id()}" />
			<textarea style="display: none" data-bind="text: help, attr: {'name': 'help' + id()}"></textarea>
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
	
			<!--  ko foreach: scoringItems() -->
			<input type="hidden" data-bind="value: id, attr: {'name': 'scoringitem' + $parent.id()}" />
			<input type="hidden" data-bind="value: type, attr: {'name': 'type' + id()}" />
			<input type="hidden" data-bind="value: correct, attr: {'name': 'correct' + id()}" />	
			<input type="hidden" data-bind="value: value, attr: {'name': 'value' + id()}" />
			<input type="hidden" data-bind="value: feedback, attr: {'name': 'feedback' + id()}" />
			<input type="hidden" data-bind="value: points, attr: {'name': 'points' + id()}" />
			<!-- /ko -->
		<!-- /ko -->
	</div>
	
	<div id="freetext-template">	
		<!-- ko if: optional() == false -->
			<span class="mandatory" style="position: absolute; margin-left: -7px; margin-top: 2px;">*</span>
		<!-- /ko -->
	
		<label class='questiontitle' data-bind='html: title, attr: {for: "answer" + id()}'></label>
				
		<!-- ko if: minCharacters() != 0 && maxCharacters() != 0 -->
			<div class='limits' data-bind="html: getMinMaxCharacters(minCharacters(), maxCharacters())"></div>
		<!-- /ko -->
		<!-- ko if: minCharacters() != 0 && maxCharacters() == 0 -->
			<div class='limits' data-bind="html: getMinCharacters(minCharacters())"></div>
		<!-- /ko -->
		<!-- ko if: minCharacters() == 0 && maxCharacters() != 0 -->
			<div class='limits' data-bind="html: getMaxCharacters(maxCharacters())"></div>
		<!-- /ko -->

		<div class='questionhelp' data-bind="html: niceHelp"></div>
	
		<!-- ko if: type == "RegExQuestion" -->
			<input type="hidden" data-bind="value: regex, attr: {'name': 'regex' + id()}" />
		<!-- /ko -->
	
		<!-- ko if: foreditor -->
		
			<!-- ko if: type == "RegExQuestion" -->
				<input type="hidden" data-bind="value: 'regex', attr: {'name': 'type' + id()}" />
			<!-- /ko -->
			<!-- ko ifnot: type == "RegExQuestion" -->
				<input type="hidden" data-bind="value: 'freetext', attr: {'name': 'type' + id()}" />	
			<!-- /ko -->
			
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />	
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />	
			<input type="hidden" data-bind="value: readonly, attr: {'name': 'readonly' + id()}" />	
			<input type="hidden" data-bind="value: isAttribute, attr: {'name': 'attribute' + id()}" />	
			<input type="hidden" data-bind="value: attributeName, attr: {'name': 'nameattribute' + id()}" />
			<input type="hidden" data-bind="value: numRows, attr: {'name': 'rows' + id()}" />
			<input type="hidden" data-bind="value: minCharacters, attr: {'name': 'min' + id()}" />
			<input type="hidden" data-bind="value: maxCharacters, attr: {'name': 'max' + id()}" />
			<input type="hidden" data-bind="value: isPassword, attr: {'name': 'password' + id()}" />
			<input type="hidden" data-bind="value: isUnique, attr: {'name': 'unique' + id()}" />
			<input type="hidden" data-bind="value: isComparable, attr: {'name': 'comparable' + id()}" />
			<textarea style="display: none" data-bind="text: help, attr: {'name': 'help' + id()}"></textarea>
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
			
			<input type="hidden" data-bind="value: scoring, attr: {'name': 'scoring' + id()}" />
			<input type="hidden" data-bind="value: points, attr: {'name': 'points' + id()}" />
			
			<!--  ko foreach: scoringItems() -->
			<input type="hidden" data-bind="value: id, attr: {'name': 'scoringitem' + $parent.id()}" />
			<input type="hidden" data-bind="value: type, attr: {'name': 'type' + id()}" />
			<input type="hidden" data-bind="value: correct, attr: {'name': 'correct' + id()}" />	
			<input type="hidden" data-bind="value: value, attr: {'name': 'value' + id()}" />
			<input type="hidden" data-bind="value: feedback, attr: {'name': 'feedback' + id()}" />
			<input type="hidden" data-bind="value: points, attr: {'name': 'points' + id()}" />
			<!-- /ko -->
	
		<!-- /ko -->
	
		<!-- ko if: maxCharacters() > 0 -->	
			<textarea data-bind="enable: !readonly(), value:getValueByQuestion(uniqueId()), attr: {'id': 'answer' + id(), 'data-id':id(), 'data-shortname': shortname(), 'name' : 'answer' + id(), 'class':css() + ' expand', 'maxlength':maxCharacters(), 'data-rows':numRows(), 'rows':numRows()}"  onkeyup="countChar(this);propagateChange();" onblur="validateInput($(this).parent(),true)"></textarea>
		<!-- /ko -->
		<!-- ko if: maxCharacters() == 0 -->	
			<textarea data-bind="enable: !readonly(), value:getValueByQuestion(uniqueId()), attr: {'id': 'answer' + id(), 'data-id':id(), 'data-shortname': shortname(), 'name' : 'answer' + id(), 'class':css() + ' expand', 'data-rows':numRows(), 'rows':numRows()}" onkeyup="countChar(this);propagateChange();" onblur="validateInput($(this).parent(),true)"></textarea>
		<!-- /ko -->
		<!-- ko if: isComparable() -->		
			<br /><span style="margin-left: 20px">${form.getMessage("label.PleaseRepeat")}</span>:<br />
			<textarea data-bind="enable: !readonly(), attr: {'data-id':id + '2', 'class': 'comparable-second ' + css() + ' expand', 'data-rows':numRows, 'rows':numRows(), 'name' : 'secondanswer' + id()}"  onblur="validateInput($(this).parent(), true)"></textarea>
		<!-- /ko -->
	</div>
	
	<div id="confirmation-template">
		<!-- ko if: optional() == false -->
			<span class="mandatory" style="position: absolute; margin-left: -7px; margin-top: 2px;">*</span>
		<!-- /ko -->
		<div class='questionhelp' data-bind="html: niceHelp"></div>
		<label class='questiontitle confirmationelement' data-bind='html: title'></label>
		<!-- ko if: usetext -->																					
			<a class="confirmationlabel" style="margin-left: 40px; cursor: pointer;" onclick="$(this).parent().find('.confirmation-dialog').modal('show')" data-bind="html:confirmationlabel"></a>
			<div class="modal confirmation-dialog">
				  <div class="modal-dialog modal-sm runnerdialog">
					  <div class="modal-content">
						  <div class="modal-header">${form.getMessage("label.Confirmation")}</div>
						  <div class="modal-body" data-bind="html: confirmationtext"></div>
						  <div class="modal-footer">
							<a style="cursor: pointer" class="btn btn-info" onclick="$(this).closest('.confirmation-dialog').modal('hide');">${form.getMessage("label.Cancel")}</a>		
						  </div>
					  </div>
				  </div>
			</div>
		<!-- /ko -->
		<!-- ko if: useupload -->		
			<div class="files" style="margin-left: 40px; margin-top: 10px;" data-bind="foreach: files">
				<!-- ko if: $parent.foreditor -->
				<input type="hidden" data-bind="value: uid(), attr: {'name': 'files' + $parent.id()}" />	
				<!-- /ko -->
				<a class="visiblelink" target="_blank" data-bind="html: name, attr: {'href':'${contextpath}/files/${form.survey.uniqueId}/' + uid()}"></a> <br />
			</div>			
		<!-- /ko -->
		
		<!-- ko if: foreditor -->
			<input type="hidden" data-bind="value: 'confirmation', attr: {'name': 'type' + id()}" />	
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />	
			<input type="hidden" data-bind="value: usetext, attr: {'name': 'usetext' + id()}" />
			<input type="hidden" data-bind="value: useupload, attr: {'name': 'useupload' + id()}" />
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
			<textarea style="display: none" data-bind="text: help, attr: {'name': 'help' + id()}"></textarea>
			<textarea style="display: none" data-bind="text: confirmationtext, attr: {'name': 'confirmationtext' + id()}"></textarea>
			<textarea style="display: none" data-bind="text: confirmationlabel, attr: {'name': 'confirmationlabel' + id()}"></textarea>
		<!-- /ko -->
	</div>
	
	<div id="rating-template">
		<label class='questiontitle' data-bind='html: title, attr: {for: "answer" + id()}'></label>
		<div class='questionhelp' data-bind="html: niceHelp"></div>
		
		<!-- ko if: foreditor -->
			<input type="hidden" data-bind="value: 'rating', attr: {'name': 'type' + id()}" />	
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />	
			<input type="hidden" data-bind="value: numIcons, attr: {'name': 'numIcons' + id()}" />
			<input type="hidden" data-bind="value: iconType, attr: {'name': 'iconType' + id()}" />
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
			<textarea style="display: none" data-bind="text: help, attr: {'name': 'help' + id()}"></textarea>
		
			<div class="hiddenratingquestions hideme">
				<!-- ko foreach: childElements() -->
				<div data-bind="attr: {'pos': $index, 'data-id': id}">
					<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'questionuid' + $parent.id(), 'data-id' : id()}" />	
					<input type="hidden" data-bind="value: shortname, attr: {'name': 'questionshortname' + $parent.id(), 'data-id' : id()}" />
					<input type="hidden" data-bind="value: optional, attr: {'name': 'questionoptional' + $parent.id(), 'data-id' : id()}" />
					<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'question' + $parent.id(), 'data-id' : id()}"></textarea>
				</div>
				<!-- /ko -->
			</div>
		<!-- /ko -->
		
		<table class="ratingtable">
			<tbody data-bind="foreach: childElements()">
				<tr class="ratingquestion" data-bind="attr: {'data-id': id}">
					<td>
						<!-- ko if: optional() == false -->
							<span class="mandatory" style="position: absolute; margin-left: -7px; margin-top: 2px;">*</span>
						<!-- /ko -->
						<div data-bind="html: title"></div>						
					</td>
					<td>
						<input data-bind="value:getValueByQuestion(uniqueId()), attr: {'id': 'input' + id(), 'data-id':id(), 'name' : 'answer' + id(), 'class' : 'rating ' + css()}" data-type="rating" type="hidden"></input>
		
						<div data-bind="foreach: new Array($parent.numIcons())">
							<a class="ratingitem" onclick="ratingClick(this)" data-bind="attr: {'data-icons' : $parents[1].numIcons(), 'data-shortname': $parents[1].shortname()}">
								<!-- ko if: $parents[1].iconType() == 0 -->
							    <img src="${contextpath}/resources/images/star_grey.png" data-bind='title: $index()+1' />
							    <!-- /ko -->
							    <!-- ko if: $parents[1].iconType() == 1 -->
							    <img src="${contextpath}/resources/images/nav_plain_grey.png" data-bind='title: $index()+1' />
							    <!-- /ko -->
							    <!-- ko if: $parents[1].iconType() == 2 -->
							    <img src="${contextpath}/resources/images/heart_grey.png" data-bind='title: $index()+1' />
							    <!-- /ko -->
						    </a>
						</div>
					</td>
				</tr>
			</tbody>
		</table>						
	
	</div>
	
	<div id="number-template">
		<!-- ko if: optional() == false -->
			<span class="mandatory" style="position: absolute; margin-left: -7px; margin-top: 2px;">*</span>
		<!-- /ko -->
		<label class='questiontitle' data-bind='html: title, attr: {for: "answer" + id()}'></label>
		
		<!-- ko if: min() != null && min() != 0 && max() != null && max() != 0 -->
			<div class='limits' data-bind="html: getMinMax(minString(), maxString())"></div>
		<!-- /ko -->
		<!-- ko if: min() != 0 && min() != null && (max() == 0 || max() == null) -->
			<div class='limits' data-bind="html: getMin(minString())"></div>
		<!-- /ko -->
		<!-- ko if: (min() == 0 || min() == null) && max() != null && max() != 0 -->
			<div class='limits' data-bind="html: getMax(maxString())"></div>
		<!-- /ko -->
		
		<div class='questionhelp' data-bind="html: niceHelp"></div>
		<input data-bind="enable: !readonly(), value:getValueByQuestion(uniqueId()), attr: {'id': 'answer' + id(), 'data-id':id(), 'data-shortname': shortname(), 'name' : 'answer' + id(), 'class':css()}" onkeyup="propagateChange();" onblur="validateInput($(this).parent())" type="text"></input><span class="unit-text" data-bind="html: unit"></span>
		<!-- ko if: foreditor -->
			<input type="hidden" data-bind="value: 'number', attr: {'name': 'type' + id()}" />	
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />
			<input type="hidden" data-bind="value: decimalPlaces, attr: {'name': 'decimalplaces' + id()}" />
			<input type="hidden" data-bind="value: unit, attr: {'name': 'unit' + id()}" />
			<input type="hidden" data-bind="value: min, attr: {'name': 'min' + id()}" />	
			<input type="hidden" data-bind="value: max, attr: {'name': 'max' + id()}" />	
			<input type="hidden" data-bind="value: readonly, attr: {'name': 'readonly' + id()}" />	
			<input type="hidden" data-bind="value: isAttribute, attr: {'name': 'attribute' + id()}" />	
			<input type="hidden" data-bind="value: attributeName, attr: {'name': 'nameattribute' + id()}" />	
			<input type="hidden" data-bind="value: isUnique, attr: {'name': 'unique' + id()}" />	
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
			<textarea style="display: none" data-bind="text: help, attr: {'name': 'help' + id()}"></textarea>

			<input type="hidden" data-bind="value: scoring, attr: {'name': 'scoring' + id()}" />
			<input type="hidden" data-bind="value: points, attr: {'name': 'points' + id()}" />
			
			<!--  ko foreach: scoringItems() -->
			<input type="hidden" data-bind="value: id, attr: {'name': 'scoringitem' + $parent.id()}" />
			<input type="hidden" data-bind="value: type, attr: {'name': 'type' + id()}" />
			<input type="hidden" data-bind="value: correct, attr: {'name': 'correct' + id()}" />	
			<input type="hidden" data-bind="value: value, attr: {'name': 'value' + id()}" />
			<input type="hidden" data-bind="value: value2, attr: {'name': 'value2' + id()}" />
			<input type="hidden" data-bind="value: feedback, attr: {'name': 'feedback' + id()}" />
			<input type="hidden" data-bind="value: min, attr: {'name': 'min' + id()}" />
			<input type="hidden" data-bind="value: max, attr: {'name': 'max' + id()}" />
			<input type="hidden" data-bind="value: points, attr: {'name': 'points' + id()}" />
			<!-- /ko -->
		<!-- /ko -->
	</div> 
	
	<div id="email-template">
		<!-- ko if: optional() == false -->
			<span class="mandatory" style="position: absolute; margin-left: -7px; margin-top: 2px;">*</span>
		<!-- /ko -->
		<label class='questiontitle' data-bind='html: title, attr: {for: "answer" + id()}'></label>
		<div class='questionhelp' data-bind="html: niceHelp"></div>
		<div class="input-group" style="margin-left: 20px;">
	    	<div class="input-group-addon" style="margin-bottom: 5px">@</div>
	      	<input data-bind="enable: !readonly(), value:getValueByQuestion(uniqueId()), attr: {'id': 'answer' + id(), 'data-id':id(), 'data-shortname': shortname(), 'name' : 'answer' + id(), 'class':css()}"  onblur="validateInput($(this).parent().parent())" onkeyup="propagateChange();" onchange="validateInput($(this).parent());" style="width: 180px; margin-left: 0px; margin-bottom: 0px !important;" type='text' maxlength="255" />
	    </div>
	    <!-- ko if: foreditor -->
			<input type="hidden" data-bind="value: 'email', attr: {'name': 'type' + id()}" />	
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />
			<input type="hidden" data-bind="value: readonly, attr: {'name': 'readonly' + id()}" />	
			<input type="hidden" data-bind="value: isAttribute, attr: {'name': 'attribute' + id()}" />	
			<input type="hidden" data-bind="value: attributeName, attr: {'name': 'nameattribute' + id()}" />	
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
			<textarea style="display: none" data-bind="text: help, attr: {'name': 'help' + id()}"></textarea>
		<!-- /ko -->
	</div>
	
	<div id="date-template">
		<!-- ko if: optional() == false -->
			<span class="mandatory" style="position: absolute; margin-left: -7px; margin-top: 2px;">*</span>
		<!-- /ko -->
		<label class='questiontitle' data-bind='html: title, attr: {for: "answer" + id()}'></label>
		
		<!-- ko if: min() != null && max() != null -->
			<div class='limits' data-bind="html: getMinMaxDate(minString(), maxString())"></div>
		<!-- /ko -->
		<!-- ko if: min() != null && max() == null -->
			<div class='limits' data-bind="html: getMinDate(minString())"></div>
		<!-- /ko -->
		<!-- ko if: min() == null && max() != null -->
			<div class='limits' data-bind="html: getMaxDate(maxString())"></div>
		<!-- /ko -->
		
		<div class='questionhelp' data-bind="html: niceHelp"></div>
		<div class="input-group">
			<!-- ko if: !foreditor && !readonly() -->
				<div class="input-group-addon" onclick='$(this).parent().find(".datepicker").datepicker( "show" );'><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span></div>
			<!-- /ko -->
			
			<!-- ko if: foreditor || readonly() -->
				<div class="input-group-addon"><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span></div>
			<!-- /ko -->
			<input data-bind="enable: !readonly(), value:getValueByQuestion(uniqueId()), attr: {'id': 'answer' + id(), 'data-id':id(), 'data-shortname': shortname(), 'name' : 'answer' + id(), 'class': 'datepicker ' + css()}" onblur="validateInput($(this).parent().parent());propagateChange();" type="text" placeholder="DD/MM/YYYY" style="display: inline; margin-left:0px; margin-bottom:0px !important;"></input>
		</div>
		
		<!-- ko if: foreditor -->
			<input type="hidden" data-bind="value: 'date', attr: {'name': 'type' + id()}" />	
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />	
			<input type="hidden" data-bind="value: minString(), attr: {'name': 'min' + id()}" />	
			<input type="hidden" data-bind="value: maxString(), attr: {'name': 'max' + id()}" />	
			<input type="hidden" data-bind="value: readonly, attr: {'name': 'readonly' + id()}" />	
			<input type="hidden" data-bind="value: isAttribute, attr: {'name': 'attribute' + id()}" />	
			<input type="hidden" data-bind="value: attributeName, attr: {'name': 'nameattribute' + id()}" />	
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
			<textarea style="display: none" data-bind="text: help, attr: {'name': 'help' + id()}"></textarea>

			<input type="hidden" data-bind="value: scoring, attr: {'name': 'scoring' + id()}" />
			<input type="hidden" data-bind="value: points, attr: {'name': 'points' + id()}" />			
			
			<!--  ko foreach: scoringItems() -->
			<input type="hidden" data-bind="value: id, attr: {'name': 'scoringitem' + $parent.id()}" />
			<input type="hidden" data-bind="value: type, attr: {'name': 'type' + id()}" />
			<input type="hidden" data-bind="value: correct, attr: {'name': 'correct' + id()}" />	
			<input type="hidden" data-bind="value: value, attr: {'name': 'value' + id()}" />
			<input type="hidden" data-bind="value: value2, attr: {'name': 'value2' + id()}" />
			<input type="hidden" data-bind="value: feedback, attr: {'name': 'feedback' + id()}" />
			<input type="hidden" data-bind="value: minDate, attr: {'name': 'minDate' + id()}" />
			<input type="hidden" data-bind="value: maxDate, attr: {'name': 'maxDate' + id()}" />
			<input type="hidden" data-bind="value: points, attr: {'name': 'points' + id()}" />
			<!-- /ko -->
		<!-- /ko -->		
	</div>
	
	<div id="upload-template">
		<!-- ko if: optional() == false -->
			<span class="mandatory" style="position: absolute; margin-left: -7px; margin-top: 2px;">*</span>
		<!-- /ko -->
		<label class='questiontitle' data-bind='html: title, attr: {for: "answer" + id()}'></label>
		<div class="questionhelp" data-bind="html: niceHelp"></div>	
		<!-- ko if: extensions() != null && extensions().length > 0 -->
			<div class="questionhelp">
				<span class='glyphicon glyphicon-question-sign'></span>&nbsp;<span data-bind="html: getExtensionsHelp(extensions())"></span>
			</div>
		<!-- /ko -->
		<input type="hidden" data-bind="attr: {'id': 'answer' + id(), 'name':'answer' + id()}" value="files" />				
		<div class="uploaded-files" data-bind="foreach: getFileAnswer(uniqueId())">
			<div>
				<a data-toggle="tooltip" title="${form.getMessage("label.RemoveUploadedFile")}" data-bind="click: function() {deleteFile($parent.id(),'${uniqueCode}',$data,$('#uploadlink' + $parent.id()));return false;}, attr: {'id' : 'uploadlink' + $parent.id() }">
					<span style="margin-right: 10px;" class="glyphicon glyphicon-trash"></span>
				</a>
				<span data-bind="html: $data"></span>
			</div>				
		</div>				
		<div data-bind="attr: {'class': css() + ' file-uploader', 'data-id':id}" style="margin-left: 10px; margin-top: 10px;"></div>
		
		<!-- ko if: foreditor -->
			<input type="hidden" data-bind="value: 'upload', attr: {'name': 'type' + id()}" />	
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />	
			<input type="hidden" data-bind="value: readonly, attr: {'name': 'readonly' + id()}" />	
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
			<textarea style="display: none" data-bind="text: help, attr: {'name': 'help' + id()}"></textarea>
			<input type="hidden" data-bind="value: extensions, attr: {'name': 'extensions' + id()}" />
		<!-- /ko -->
	</div>
	
	<div id="download-template">
		<label class='questiontitle' data-bind='html: title, attr: {for: "answer" + id()}'></label>
		<div class="questionhelp" data-bind="html: niceHelp"></div>	
		<div class="files" data-bind="foreach: files">
			<!-- ko if: $parent.foreditor -->
			<input type="hidden" data-bind="value: uid(), attr: {'name': 'files' + $parent.id()}" />	
			<!-- /ko -->
			<a class="visiblelink" target="_blank" data-bind="attr: {'href': '${contextpath}/files/${form.survey.uniqueId}/' + uid()}, html: name"></a> <br />
		</div>
		<!-- ko if: foreditor -->
		
			<!-- ko if: files().length == 0 -->
			<div class="files">
				<i>[${form.getMessage("message.AddFileForDownload")}]</i>
			</div>
			<!-- /ko -->
		
			<input type="hidden" data-bind="value: 'download', attr: {'name': 'type' + id()}" />	
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />	
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
			<textarea style="display: none" data-bind="text: help, attr: {'name': 'help' + id()}"></textarea>
		<!-- /ko -->
	</div>
	
	<div id="gallery-template">
		<!-- ko if: optional() == false -->
			<span class="mandatory" style="position: absolute; margin-left: -7px; margin-top: 2px;">*</span>
		<!-- /ko -->
		<label class='questiontitle' data-bind='html: title, attr: {for: "answer" + id()}'></label>
		
		<!-- ko if: selection() && limit != null && limit() > 0 -->
			<div class='limits' data-bind="html: getMaxSelections(limit())"></div>
		<!-- /ko -->

		<div class='questionhelp' data-bind="html: niceHelp"></div>
		
		<div class="gallery-div" style="width: 920px; max-width: 100%; text-align:left;">				
			<!-- ko if: files().length == 0 -->
				<table data-bind="attr: {'class':'gallery-table limit' + limit()}">
					<tbody>
						<tr>
							<td>
								<img style="max-width: none;" src="${contextpath}/resources/images/photo_scenery.png" data-width="128" data-original-width="247" width="247px">
							</td>
							<td>
								<img style="max-width: none;" src="${contextpath}/resources/images/photo_scenery.png" data-width="128" data-original-width="247" width="247px">
							</td>
						</tr>		
					</tbody>
				</table>
			
			<!-- /ko -->
			
			<!-- ko if: files().length > 0 -->
			<table style="width: 100%" data-bind="attr: {'class':'gallery-table limit' + limit()}">
				<tbody data-bind="foreach: rows">	
					<tr data-bind="foreach: $data">
						<td data-bind="attr: {'data-uid':uid()}" style="vertical-align: top">
							<div class="galleryinfo">
								<span data-bind="if: $parents[1].selection()">																			
									<input data-bind="value: $parentContext.$index() * $parents[1].columns() + $index(), checked: getValueByQuestion($parents[1].uniqueId()).indexOf(($parentContext.$index() * $parents[1].columns() + $index()).toString()) > -1, attr: {'onclick': $parents[1].readonly() ? 'return false;':'propagateChange();', 'data-id': $parents[1].id() + ($parentContext.$index() * $parents[1].columns() + $index()), 'data-shortname': $parents[1].shortname(), 'class': $parents[1].css() + ' selection', 'name':'answer'+$parents[1].id()}" type="checkbox" />
								</span>
								<!-- ko if: $parents[1].numbering() -->
								<span data-bind='html: ($parentContext.$index() * $parents[1].columns() + $index()+1) + "."'></span>
								<!-- /ko -->
								<span data-bind='html: name().replace("%20"," ")'></span>
							</div>
							<a onclick="showGalleryBrowser($(this).parent())">																	
								<img class="gallery-image" data-bind="attr: {'alt': cleanComment(), 'src':'${contextpath}/files/${form.survey.uniqueId}/'+ uid(), 'data-width': width(), 'data-original-width': Math.round((850-20-($parents[1].columns()*30))/$parents[1].columns()), 'width': Math.round((850-20-($parents[1].columns()*30))/$parents[1].columns())+'px'}"  style="max-width: 100%;" />	
							</a>
							<div class="comment" data-bind="html: comment"></div>	
							<!-- ko if: $parents[1].foreditor -->
								<input type="hidden" data-bind="value: name, attr: {'name': 'name' + ($parentContext.$index() * $parents[1].columns() + $index() + 1) + $parents[1].id()}" />	
								<input type="hidden" data-bind="value: uid, attr: {'name': 'image' + ($parentContext.$index() * $parents[1].columns() + $index() + 1) + $parents[1].id()}" />	
								<input type="hidden" data-bind="value: longdesc, attr: {'name': 'longdesc' + ($parentContext.$index() * $parents[1].columns() + $index() + 1) + $parents[1].id()}" />	
								<textarea style="display: none" data-bind="text: comment, attr: {'name': 'comment' + ($parentContext.$index() * $parents[1].columns() + $index() + 1) + $parents[1].id()}"></textarea>
							<!-- /ko -->						
						</td>
					</tr>
				</tbody>
			</table>
			<!-- /ko -->								
		</div>
		<!-- ko if: foreditor -->
			<input type="hidden" data-bind="value: 'gallery', attr: {'name': 'type' + id()}" />	
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />	
			<input type="hidden" data-bind="value: readonly, attr: {'name': 'readonly' + id()}" />
			<input type="hidden" data-bind="value: columns, attr: {'name': 'columns' + id()}" />
			<input type="hidden" data-bind="value: selection, attr: {'name': 'selectable' + id()}" />
			<input type="hidden" data-bind="value: numbering, attr: {'name': 'numbering' + id()}" />
			<input type="hidden" data-bind="value: limit, attr: {'name': 'limit' + id()}" />
			<input type="hidden" data-bind="value: files().length, attr: {'name': 'count' + id()}" />
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
			<textarea style="display: none" data-bind="text: help, attr: {'name': 'help' + id()}"></textarea>
		<!-- /ko -->
		<!-- ko ifnot: foreditor -->
			<div class="modal" data-backdrop="static">
				<div data-bind="attr: {'data-mobile': '' + ismobile, 'class': 'modal-dialog runnerdialog ' + (ismobile ? 'modal-sm' : (istablet ? 'modal-md' : 'modal-lg'))}">
				<div class="modal-content">
				  <div class="modal-header">${form.getMessage("label.BrowseGallery")}</div>
				  <div data-bind="foreach: files()" class="modal-body"  data-bind="attr: {'style': 'overflow: auto; height: ' + ismobile ? '400px' : '600px;'}">
				  		<div class="gallery-image hideme" style="text-align: center" data-bind="attr: {'data-uid': uid()}">
							<div class="galleryinfo">
								<span data-bind="if: $parent.selection()">																			
									<input onclick="synchronizeGallerySelection(this)" type="checkbox" />
								</span>
								<!-- ko if: $parent.numbering() -->
								<span data-bind='html: ($index()+1) + "."'></span>
								<!-- /ko -->
								<span data-bind='html: name().replace("%20"," ")'></span>
							</div>
						
							<img style="width: 95%;" data-bind="attr: {'alt':cleanComment(), 'src':'${contextpath}/files/${form.survey.uniqueId}/'+uid()}" />	
							<div class="gallery-image-comment" style="text-align: center; padding: 15px;" data-bind="html: comment()"></div>							
						</div>
				  </div>
				  <div class="modal-footer">
				  	<a class="btn btn-default" onclick="openPreviousImage($(this).closest('.modal'))"><span class="glyphicon glyphicon-chevron-left"></span></a>
					<a class="btn btn-info" onclick="$(this).closest('.modal').modal('hide');">${form.getMessage("label.Close")}</a>			
				  	<a class="btn btn-default" onclick="openNextImage($(this).closest('.modal'))"><span class="glyphicon glyphicon-chevron-right"></span></a>
				  </div>
				 </div>
				 </div>
			</div>
		<!-- /ko -->		
	</div>
	
	<div id="matrix-template">
		<!-- ko if: foreditor -->
			<input type="hidden" data-bind="value: 'matrix', attr: {'name': 'type' + id()}" />
			<input type="hidden" data-bind="value: tableType, attr: {'name': 'tabletype' + id()}" />	
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />
			<input type="hidden" data-bind="value: order, attr: {'name': 'order' + id()}" />	
			<input type="hidden" data-bind="value: readonly, attr: {'name': 'readonly' + id()}" />	
			<input type="hidden" data-bind="value: isAttribute, attr: {'name': 'attribute' + id()}" />	
			<input type="hidden" data-bind="value: attributeName, attr: {'name': 'nameattribute' + id()}" />	
			<input type="hidden" data-bind="value: isInterdependent, attr: {'name': 'interdependent' + id()}" />	
			<input type="hidden" data-bind="value: isSingleChoice, attr: {'name': 'single' + id()}" />	
			<input type="hidden" data-bind="value: minRows, attr: {'name': 'rowsmin' + id()}" />	
			<input type="hidden" data-bind="value: maxRows, attr: {'name': 'rowsmax' + id()}" />	
			<input type="hidden" data-bind="value: widths, attr: {'name': 'widths' + id()}" />	
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
			<textarea style="display: none" data-bind="text: help, attr: {'name': 'help' + id()}"></textarea>
		<!-- /ko -->		
	
		<!-- ko if: optional() == false -->
			<span class="mandatory" style="position: absolute; margin-left: -7px; margin-top: 2px;">*</span>
		<!-- /ko -->
		<label class='questiontitle' data-bind='html: title, attr: {for: "answer" + id()}'></label>
		
		<!-- ko if: minRows() != 0 && maxRows() != 0 -->
			<div class='limits' data-bind="html: getMinMaxRows(minRows(), maxRows())"></div>
		<!-- /ko -->
		<!-- ko if: minRows() != 0 && maxRows() == 0 -->
			<div class='limits' data-bind="html: getMinRows(minRows())"></div>
		<!-- /ko -->
		<!-- ko if: minRows() == 0 && maxRows() != 0 -->
			<div class='limits' data-bind="html: getMaxRows(maxRows())"></div>
		<!-- /ko -->
				
		<div class="questionhelp" data-bind="html: niceHelp"></div>
		
		<!-- ko if: ismobile || istablet -->
			<div data-bind="attr: {'class': 'matrixdiv' + css()}">
				<!-- ko foreach: questions -->	
					<div data-bind="attr: {'class': $data.isDependentMatrixQuestion() && isInvisible($data.uniqueId()) ? 'matrix-question untriggered hideme':'matrix-question', 'id' : id(), 'data-id': id(), 'data-triggers': getTriggersByQuestion(uniqueId())}" style="margin-top: 10px;">
						<!-- ko if: optional() == false -->
							<span class="mandatory" style="position: absolute; margin-left: -7px;">*</span>
						<!-- /ko -->
						<div data-bind="html: title" style="font-size: 90%"></div>										
						<div class="answer-columns" style="margin-top: 5px; font-size: 90%;">
							<table class="answers-table" data-bind="foreach: $parent.answers">							
								<tr>
									<td>
										<input data-bind="enable: !$parents[1].readonly(), checked: getPAByQuestion2($parent.uniqueId(), uniqueId(), id()), attr: {value: id().toString(), 'onclick': $parents[1].readonly() ? 'return false;' : 'checkSingleClick(this); event.stopImmediatePropagation();', 'id': $parent.id().toString() + id().toString(), 'data-id': $parent.id().toString() + id().toString(), 'data-shortname': $parent.shortname() + '|' + shortname(), 'class': $parent.css() + ' trigger', 'name': 'answer' + $parent.id(), 'data-dependencies': $parents[1].dependentElementsStrings()[$index() + ($parentContext.$index() * ($parents[1].columns()-1))], 'data-cellid' : $parent.id() + '|' + id(), type: $parents[1].isSingleChoice() ? 'radio' : 'checkbox', role: $parents[1].isSingleChoice() ? 'radio' : 'checkbox', 'data-dummy': getPAByQuestion2($parent.uniqueId(), uniqueId(), id())}" />
										<input type="hidden" data-bind="attr: {'name': 'dependencies' + $parents[1].id(), 'value': $parents[1].dependentElementsStrings()[$index() + ($parentContext.$index() * ($parents[1].columns()-1))]}" />	
									</td>
									<td>
										<label data-bind="attr: {for: $parent.id() + id()}">
											<span class="answertext" data-bind="html: title"></span>
										</label>																													
									</td>
								</tr>														
							</table>
						</div>
					</div>
				<!-- /ko -->				
			</div>
		<!-- /ko -->
		
		<!-- ko if: !ismobile && !istablet  -->
		<div data-bind="attr: {'style': istablet ? 'position: relative; max-width: 100%; overflow-x: hidden' : 'width: 100%'}">
		
			<!-- ko if: istablet -->			
				<button class="btn btn-default scrolltableleft" onclick="scrollTable(this,false);return false;"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></button>
				<button class="btn btn-default scrolltableright" onclick="scrollTable(this,true);return false;"><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></button>				
			<!-- /ko -->
		
			<!-- ko if: foreditor -->
			<div class="hiddenmatrixquestions hideme">
				<!-- ko foreach: questions() -->
				<div data-bind="attr: {'pos': $index, 'data-id': id}">
					<input type="hidden" data-bind="value: 'text', attr: {'name': 'type' + id()}" />
					<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
					<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />
					<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />
					<input type="hidden" data-bind="value: readonly, attr: {'name': 'readonly' + id()}" />
					<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
					
					<!-- ko foreach: $parent.answers() -->
						<input type="hidden" data-bind="attr: {'name': 'dependencies' + $parents[1].id(), 'value': $parents[1].dependentElementsStrings()[$index() + ($parent.originalIndex() * ($parents[1].columns()-1))], 'data-qaid': $parent.id() + '|' + id()}" />
					<!-- /ko -->
					
				</div>
				<!-- /ko -->
			</div>
			<!-- /ko -->
		
			<table data-bind="attr: {'class':'matrixtable ' + css(), 'style': tableType() == 1 ? 'width: 900px' : 'width: auto; max-width: auto'}">			
				<thead>
					<tr>
						<th data-bind="attr: {'style': tableType() != 2 ? '' : 'width: ' + getWidth(widths(), 0)}">&nbsp;</th>
						<!-- ko foreach: answers -->
						<th class="matrix-header" scope="col" data-bind="attr: {'id' : id(), 'data-id': id(), 'style': $parent.tableType() != 2 ? '' : 'width: ' + getWidth($parent.widths(), $index()+1)}">
							<!-- ko if: $parent.foreditor -->
							<input type="hidden" data-bind="value: 'text', attr: {'name': 'type' + id()}" />
							<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
							<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />
							<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />
							<input type="hidden" data-bind="value: readonly, attr: {'name': 'readonly' + id()}" />
							<textarea style="display: none" data-bind="text: title, attr: {'name': 'text' + id()}"></textarea>
							 <!-- /ko -->
							<span class="matrixheadertitle" data-bind="html: title"></span>
						</th>
						 <!-- /ko -->
					</tr>
				</thead>
				<tbody>					
					<!-- ko foreach: questionsOrdered() -->			
					<tr data-bind="attr: {'class': $data.isDependentMatrixQuestion() && isInvisible($data.uniqueId()) ? 'matrix-question untriggered hideme':'matrix-question', 'data-id': id(), 'data-triggers': getTriggersByQuestion(uniqueId()) + ';' + ($parent.foreditor ? '' : getTriggersByQuestion($parent.uniqueId))}"> 
						<th class="matrix-header" scope="row" data-bind="attr: {'id' : id(), 'data-id': id}">
							<!-- ko if: optional() == false -->
								<span class="mandatory" style="position: absolute; margin-left: -7px; margin-top: 3px;">*</span>
							<!-- /ko -->
							<span class="matrixheadertitle" data-bind="html: title"></span>
						</th>
						<!-- ko foreach: $parent.answers -->
							<td class="matrix-cell">
						 		<input type="radio" data-bind="enable: !$parents[1].readonly() && !$parents[1].foreditor, checked: getPAByQuestion2($parent.uniqueId(), uniqueId(), id()), attr: {value: id(), 'data-shortname': $parent.shortname() + '|' + shortname(), 'onclick': $parents[1].readonly() ? 'return false;' : 'checkSingleClick(this); event.stopImmediatePropagation();propagateChange();', 'id': $parent.id().toString() + id().toString(), 'data-id': $parent.id().toString() + id().toString(), 'aria-labelledby': $parent.id().toString() + ' ' + id().toString(), 'class': $parent.css() + ' trigger', 'name': 'answer' + $parent.id(), 'data-dependencies': $parents[1].dependentElementsStrings()[$index() + ($parent.originalIndex() * ($parents[1].columns()-1))], 'data-cellid' : $parent.id() + '|' + id(), type: $parents[1].isSingleChoice() ? 'radio' : 'checkbox', role: $parents[1].isSingleChoice() ? 'radio' : 'checkbox', 'data-dummy': getPAByQuestion2($parent.uniqueId(), uniqueId(), id())}" />
							</td>
						 <!-- /ko -->
					</tr>
					<!-- /ko -->
				</tbody>
			</table>
		</div>
		
		<!-- /ko -->
	</div>
	
	<div id="table-template">
		<!-- ko if: foreditor -->
			<input type="hidden" data-bind="value: 'table', attr: {'name': 'type' + id()}" />
			<input type="hidden" data-bind="value: tableType, attr: {'name': 'tabletype' + id()}" />	
			<input type="hidden" data-bind="value: uniqueId(), attr: {'name': 'uid' + id()}" />	
			<input type="hidden" data-bind="value: optional, attr: {'name': 'optional' + id()}" />
			<input type="hidden" data-bind="value: shortname, attr: {'name': 'shortname' + id()}" />
			<input type="hidden" data-bind="value: readonly, attr: {'name': 'readonly' + id()}" />	
			<input type="hidden" data-bind="value: widths, attr: {'name': 'widths' + id()}" />	
			<textarea style="display: none" data-bind="text: originalTitle, attr: {'name': 'text' + id()}"></textarea>
			<textarea style="display: none" data-bind="text: help, attr: {'name': 'help' + id()}"></textarea>
		<!-- /ko -->
		<!-- ko if: optional() == false -->
			<span class="mandatory" style="position: absolute; margin-left: -7px; margin-top: 2px;">*</span>
		<!-- /ko -->
		<label class='questiontitle' data-bind='html: title, attr: {for: "answer" + id()}'></label>
		<div class="questionhelp" data-bind="html: niceHelp"></div>	
		
		<!-- ko if: ismobile || istablet -->
			<!-- ko foreach: questions -->	
				<div data-bind="attr: {'class': $data.isDependentMatrixQuestion() && isInvisible($data.uniqueId()) ? 'matrix-question untriggered hideme':'matrix-question', 'id' : id(), 'data-id': id(), 'triggers': getTriggersByQuestion(uniqueId())}" style="margin-top: 10px;">
					<div data-bind="html: title" style="font-size: 90%; font-weight: bold"></div>										
					<div style="margin-top: 5px;;">
						<div  data-bind="foreach: $parent.answers">
							<!-- ko if: optional() == false -->
								<span class="mandatory" style="position: absolute; margin-left: -7px;">*</span>
							<!-- /ko -->				
							<div data-bind="html: title" style="font-size: 90%"></div>	
							<textarea onblur="validateInput($(this).closest('.tabletable').parent(), true)" data-bind="enable: !$parents[1].readonly(), value: getTableAnswer($parents[1].uniqueId(), $parentContext.$index()+1, $index()+1), attr: {'data-id': $parents[1].id() + $parentContext.$index() + '' + $index(), 'data-shortname': $parent.shortname() + '|' + shortname(), 'class':$parents[1].css() + ' ' + $parents[0].css(), 'name':'answer' + $parents[1].id() + '|' + ($parentContext.$index()+1) + '|' + ($index()+1)}"></textarea>
						</div>
					</div>
				</div>
			<!-- /ko -->		
		<!-- /ko -->
		
		<!-- ko if: !ismobile && !istablet -->
		<div data-bind="attr: {'style': istablet ? 'position: relative; max-width: 100%; overflow-x: hidden' : 'width: 100%'}">

			<table data-bind="attr: {'data-widths':widths(), 'id':id(), 'data-readonly': readonly, 'style': tableType() == 1 ? 'width: 900px' : 'width: auto; max-width: auto'}" class="tabletable">	
				<tbody>
					<tr style="background-color: #eee;">
						<th class="table-header" data-bind="attr: {'style': tableType() != 2 ? '' : 'width: ' + getWidth(widths(), 0)}">&nbsp;</th>
						<!-- ko foreach: answers -->
						<th class="table-header" scope="col" data-bind="attr: {'id' : id(), 'data-id' : id(), 'data-shortname' : shortname, 'data-uid' : uniqueId(), 'style': $parent.tableType() != 2 ? '' : 'width: ' + getWidth($parent.widths(), $index()+1)}">
							<span data-bind="html: title"></span>
							<!-- ko if: $parent.foreditor -->
							<textarea style="display: none" data-bind="text: originalTitle"></textarea>
							 <!-- /ko -->
						</th>
						 <!-- /ko -->
					</tr>
					<!-- ko foreach: questions -->
					<tr data-bind="attr: {'data-id': id()}"> 
						<th scope="row" style="padding-left: 10px" class="table-header" data-bind="attr: {'id' : id(), 'data-id' : id(),'data-shortname' : shortname, 'data-uid' : uniqueId(), 'data-optional' : optional().toString()}">
							<!-- ko if: optional() == false -->
								<span class="mandatory" style="position: absolute; margin-left: -7px; margin-top: 3px;">*</span>
							<!-- /ko -->
							
							<span data-bind="html: title"></span>
							<!-- ko if: $parent.foreditor -->
							<textarea style="display: none" data-bind="text: originalTitle"></textarea>
							 <!-- /ko -->
						</th>
						<!-- ko foreach: $parent.answers -->
							<td style="padding: 2px;">
								<textarea onblur="validateInput($(this).closest('.tabletable').parent(), true)" onkeyup="propagateChange();" data-bind="enable: !$parents[1].readonly(), value: getTableAnswer($parents[1].uniqueId(), $parentContext.$index()+1, $index()+1), attr: {'data-id': $parents[1].id() + $parentContext.$index() + '' + $index(), 'data-shortname': $parent.shortname() + '|' + shortname(), 'class':$parents[1].css() + ' ' + $parents[0].css(), 'name':'answer' + $parents[1].id() + '|' + ($parentContext.$index()+1) + '|' + ($index()+1), 'aria-labelledby': $parent.id().toString() + ' ' + id().toString()}"></textarea>
							</td>
						 <!-- /ko -->
					</tr>
					<!-- /ko -->
				</tbody>	
			</table>
		</div>
		<!-- /ko -->	
	</div>

</div>