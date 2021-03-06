package com.ec.survey.controller;

import com.ec.survey.model.administration.GlobalPrivilege;
import com.ec.survey.model.administration.User;
import com.ec.survey.model.attendees.Attendee;
import com.ec.survey.model.attendees.Share;
import com.ec.survey.service.AdministrationService;
import com.ec.survey.service.AttendeeService;
import com.ec.survey.service.SessionService;
import com.ec.survey.service.SurveyService;
import com.ec.survey.tools.NotAgreedToTosException;
import com.ec.survey.tools.Tools;
import com.ec.survey.tools.Ucs2Utf8;
import com.ec.survey.tools.WeakAuthenticationException;

import org.apache.commons.validator.routines.EmailValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

@Controller
@RequestMapping("/settings")
public class SettingsController extends BasicController {
		
	@Resource(name = "sessionService")
	private SessionService sessionService;
	
	@Resource(name = "surveyService")
	private SurveyService surveyService;
	
	@Resource(name = "administrationService")
	private AdministrationService administrationService;
	
	@Resource(name="attendeeService")
	private AttendeeService attendeeService;
	
	@Autowired private LocaleResolver localeResolver;
	
	@RequestMapping(method = {RequestMethod.GET, RequestMethod.HEAD})
	public String root(HttpServletRequest request, Locale locale, Model model) throws NotAgreedToTosException, WeakAuthenticationException {	
		//check user (e.g. weak authentication)
		sessionService.getCurrentUser(request);
		model.addAttribute("languages", surveyService.getLanguages());
    	return "settings/skin";
	}	
	
	@RequestMapping(value = "/myAccount", method = {RequestMethod.GET, RequestMethod.HEAD})
	public String myAccount(HttpServletRequest request, ModelMap model, Locale locale) throws NotAgreedToTosException, WeakAuthenticationException{
		model.addAttribute("languages", surveyService.getLanguages());
		
		String message = request.getParameter("message");
		if (message != null)
		{
			switch(message)
			{
				case "password":
					model.addAttribute("message", resources.getMessage("info.PasswordChanged", null, "The password has been changed", locale));
					break;
				case "email":
					model.addAttribute("message", resources.getMessage("message.NewEmailAddressSend", null, "The email address will be changed after confirmation", locale));
					break;
				case "language":
					User user = sessionService.getCurrentUser(request);
					model.addAttribute("message", resources.getMessage("message.LanguageChanged", null, "The language has been changed", new Locale(user.getLanguage())));
					break;
				case "pivot":
					model.addAttribute("message", resources.getMessage("message.LanguageChanged", null, "The language has been changed", locale));
					break;
			}
		}
		
		return "settings/myAccount";
	}
	
	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public String changePassword(HttpServletRequest request, ModelMap model, Locale locale) throws NotAgreedToTosException, WeakAuthenticationException{
		
		String oldPassword = request.getParameter("oldpassword");
		String newPassword = request.getParameter("newpassword");
		String newPassword2 = request.getParameter("newpassword2");
		
		model.addAttribute("languages", surveyService.getLanguages());
		
		if (newPassword == null || newPassword2 == null || newPassword.trim().length() == 0)
		{
			model.addAttribute("error", resources.getMessage("message.ValidPassword", null, "Please provide a valid password", locale));
			model.addAttribute("operation","changePassword");
			return "settings/myAccount";
		}
		
		if (!newPassword.equals(newPassword2))
		{
			model.addAttribute("error", resources.getMessage("validation.NewPasswordsDontMatch", null, "The new passwords do not match", locale));
			model.addAttribute("operation","changePassword");
			return "settings/myAccount";
		}
		
		User user = sessionService.getCurrentUser(request);
		
		if (oldPassword == null || !Tools.isPasswordValid(user.getPassword(), oldPassword + user.getPasswordSalt()))
		{
			model.addAttribute("error", resources.getMessage("validation.OldPasswordWrong", null, "The old password is wrong", locale));
			model.addAttribute("operation","changePassword");
			return "settings/myAccount";
		}		
		
		if (Tools.isPasswordWeak(newPassword))
		{
			model.addAttribute("error", resources.getMessage("error.PasswordWeak", null, "This password does not fit our password policy. Please choose a password between 8 and 16 characters with at least one digit and one non-alphanumeric characters (e.g. !?$&%...).", locale));
			model.addAttribute("operation","changePassword");
			return "settings/myAccount";
		}
		
		user.setPassword(Tools.hash(newPassword + user.getPasswordSalt()));
		
		administrationService.updateUser(user);
		sessionService.setCurrentUser(request, user);		
		
		return "redirect:/settings/myAccount?message=password";		
	}
	
	@RequestMapping(value = "/changeEmail", method = RequestMethod.POST)
	public String changeEmail(HttpServletRequest request, ModelMap model, Locale locale) throws NotAgreedToTosException, WeakAuthenticationException{
		
		String password = request.getParameter("password");
		String email = request.getParameter("newemail");
		String email2 = request.getParameter("newemail2");
		
		model.addAttribute("languages", surveyService.getLanguages());
		
		if (email == null || email2 == null || email.trim().length() == 0)
		{
			model.addAttribute("error", resources.getMessage("error.ValidEmail", null, "Please provide a valid email address", locale));
			model.addAttribute("operation","changeEmail");
			return "settings/myAccount";
		}
		
		if (!email.equals(email2))
		{
			model.addAttribute("error", resources.getMessage("error.EmailsDontMatch", null, "The email addresses do not match", locale));
			model.addAttribute("operation","changeEmail");
			return "settings/myAccount";
		}
		
		User user = sessionService.getCurrentUser(request);
		
		if (password == null || !Tools.isPasswordValid(user.getPassword(), password + user.getPasswordSalt()))
		{
			model.addAttribute("error", resources.getMessage("error.WrongPassword", null, "The password is wrong", locale));
			model.addAttribute("operation","changeEmail");
			return "settings/myAccount";
		}		
		
		if (!EmailValidator.getInstance().isValid(email))
		{
			model.addAttribute("error", resources.getMessage("error.InvalidEmail", null, "The email address is not valid", locale));
			model.addAttribute("operation","changeEmail");
			return "settings/myAccount";
		}	
		
		user.setEmailToValidate(email);
		administrationService.updateUser(user);
		
		if (!administrationService.sendNewEmailAdressValidationEmail(user)) {
			model.addAttribute("error", resources.getMessage("error.InvalidEmail", null, "The confirmation email could not be sent", locale));
			model.addAttribute("operation","changeEmail");
			return "settings/myAccount";
		}
		
		return "redirect:/settings/myAccount?message=email";	
	}
	
	@RequestMapping(value = "/changeLanguage", method = RequestMethod.POST)
	public String changeLanguage(HttpServletRequest request, HttpServletResponse response, ModelMap model, Locale locale) throws NotAgreedToTosException, WeakAuthenticationException{
		String lang = request.getParameter("change-lang");
			
		User user = sessionService.getCurrentUser(request);
		
		user.setLanguage(lang);
		administrationService.updateUser(user);
		
		sessionService.setCurrentUser(request, user);
		
		localeResolver.setLocale(request, response, new Locale(user.getLanguage()));
	
		return "redirect:/settings/myAccount?message=language";
	}
	
	@RequestMapping(value = "/changePivotLanguage", method = RequestMethod.POST)
	public String changePivotLanguage(HttpServletRequest request, ModelMap model, Locale locale) throws NotAgreedToTosException, WeakAuthenticationException{
		String lang = request.getParameter("change-lang");
			
		User user = sessionService.getCurrentUser(request);
		
		user.setDefaultPivotLanguage(lang);
		administrationService.updateUser(user);
		
		sessionService.setCurrentUser(request, user);
		return "redirect:/settings/myAccount?message=pivot";
	}
			
	@RequestMapping(value = "/shares")
	public ModelAndView shares(HttpServletRequest request, Locale locale) throws NotAgreedToTosException, WeakAuthenticationException{
		User user = sessionService.getCurrentUser(request);
		
		String delete = request.getParameter("delete");
		
		if (delete != null && delete.trim().length() > 0)
		{
			Share share = attendeeService.getShare(Integer.parseInt(delete));
			if (user.getGlobalPrivileges().get(GlobalPrivilege.ContactManagement) == 2 || share.getOwner().getId().equals(user.getId()))
			{
				attendeeService.deleteShare(Integer.parseInt(delete));
			}
		}
		
		int ownerId;
		if (user.getGlobalPrivileges().get(GlobalPrivilege.ContactManagement) == 2)
    	{
			ownerId = -1;
    	} else {
    		ownerId = user.getId();    		
    	}
		
		List<Share> shares = attendeeService.getShares(ownerId);
		List<Share> passiveShares = attendeeService.getPassiveShares(user.getId());
		
		ModelAndView result = new ModelAndView("settings/shares");
		
		result.addObject("shares", shares);
		result.addObject("passiveShares", passiveShares);
		result.addObject("attributeNames", user.getSelectedAttributes());
    	result.addObject("allAttributeNames", attendeeService.getAllAttributes(ownerId));
		
 		return result;
	}
	
	@RequestMapping(value = "/shareEdit/{pid}", method = {RequestMethod.GET, RequestMethod.HEAD})
	public ModelAndView shareEdit(@PathVariable String pid, HttpServletRequest request, Locale locale) throws NotAgreedToTosException, WeakAuthenticationException{
		int id = Integer.parseInt(pid);		
		User user = sessionService.getCurrentUser(request);
		Share share = attendeeService.getShare(id);
		
		ModelAndView result = shares(request, locale);
		
		if (share == null)
		{
			result.addObject("message", resources.getMessage("message.ShareNotFound", null, "Share not found", locale));
		} else {
			
			if (! share.getOwner().getId().equals(user.getId()) && user.getGlobalPrivileges().get(GlobalPrivilege.ContactManagement) != 2 && !(share.getReadonly() || ! share.getRecipient().getId().equals(user.getId())))
			{				
				if (share.getReadonly() || ! share.getRecipient().getId().equals(user.getId()))
				{				
					result.addObject("message", resources.getMessage("error.ShareUnauthorized", null, "You are not authorized to edit this share.", locale));
					return result;
				}
			}
			
			result.addObject("shareToEdit", share);
			if (! share.getOwner().getId().equals(user.getId()) && user.getGlobalPrivileges().get(GlobalPrivilege.ContactManagement) != 2 && share.getReadonly())
			{
				result.addObject("readonly", true);
			} else {
				result.addObject("readonly", false);
			}
		}
		
		return result;
	}
	
	@RequestMapping(value = "/userExists", headers="Accept=*/*", method=RequestMethod.GET)
	public @ResponseBody boolean userExists(HttpServletRequest request, HttpServletResponse response ) {
		HashMap<String,String[]> parameters = Ucs2Utf8.requestToHashMap(request);
		
		String login = parameters.get("login")[0];
		
		User user;
		try {
			user = administrationService.getUserForLogin(login);			
		} catch (Exception e) {
			return false;
		}
		
		return user != null;
	}
	
	@RequestMapping(value = "/createStaticShare", method = RequestMethod.POST)
	public ModelAndView createShares(HttpServletRequest request, Locale locale) throws NotAgreedToTosException, WeakAuthenticationException{
		
		User user = sessionService.getCurrentUser(request);
		
		HashMap<String,String[]> parameters = Ucs2Utf8.requestToHashMap(request);
				
		String shareName =  parameters.get("shareName")[0];
		String shareMode =  parameters.get("shareMode")[0];
		String recipientname =  parameters.get("recipientName")[0];
		
		String shareToEdit = request.getParameter("shareToEdit");
		
		User recipient = null;
		try {
			recipient = administrationService.getUserForLogin(recipientname);
		} catch (Exception e) {
			ModelAndView result = shares(request,locale);
			result.addObject("message", resources.getMessage("error.UnknownRecipient", null, "The recipient does not exist", locale));
			return result;
		}
	
		parameters.remove("shareName");
		parameters.remove("shareMode");
			
		List<Attendee> attendees = new ArrayList<>();
		
		for (String key : parameters.keySet())
		{
			if (key.startsWith("att"))
			{
				int intKey = Integer.parseInt(key.substring(3));				
				
				Attendee attendee = attendeeService.get(intKey);
				attendees.add(attendee);
			}
		}
		
		Share share = null;
		
		if (shareToEdit == null)
		{
			share = new Share();
			share.setOwner(user);
		} else {
			share = attendeeService.getShare(Integer.parseInt(shareToEdit));
			
			if (share == null)
			{
				ModelAndView result = shares(request, locale);
				result.addObject("message", resources.getMessage("error.ShareNotFound", null, "Share not found", locale));
				return result;
			}
			
			if (!share.getOwner().getId().equals(user.getId()) && user.getGlobalPrivileges().get(GlobalPrivilege.ContactManagement) != 2 && !(share.getReadonly() || ! share.getRecipient().getId().equals(user.getId())))
			{				
				if (share.getReadonly() || ! share.getRecipient().getId().equals(user.getId()))
				{				
					ModelAndView result = shares(request, locale);
					result.addObject("message", resources.getMessage("error.ShareUnauthorized", null, "You are not authorized to edit this share.", locale));
					return result;
				}
			}
		}		
	
		share.setName(shareName);
		if (shareMode.equalsIgnoreCase("readwrite"))
		{
			share.setReadonly(false);
		} else {
			share.setReadonly(true);
		}
		
		share.setAttendees(attendees);
		share.setRecipient(recipient);
		attendeeService.save(share);
		
		return shares(request, locale);
	}
		
}
