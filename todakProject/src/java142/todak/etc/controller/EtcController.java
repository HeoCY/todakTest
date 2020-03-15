package java142.todak.etc.controller;

import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import java142.todak.etc.service.EtcService;
import java142.todak.etc.utils.LoginSession;
import java142.todak.etc.utils.MimeMailSender;
import java142.todak.human.vo.MemberVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value="/etc")
public class EtcController {
	
	Logger logger = Logger.getLogger(EtcController.class);
	
	@Autowired
	private EtcService etcService;
	
	@RequestMapping(value="/login")
	public String login(@ModelAttribute MemberVO hmvo,
						HttpServletRequest request,
						Model model){
		logger.info("(log) login entered");
		logger.info(" id >>> " + hmvo.getHm_id());
		logger.info(" pass >>> " + hmvo.getHm_pw());
		
		// ��ȣȭ
//		BCryptPasswordEncoder bcpe = new BCryptPasswordEncoder();
//		logger.info(" encoded pass >>> " + bcpe.encode(hmvo.getHm_pw()));
//		String encodedPass = bcpe.encode(hmvo.getHm_pw());
//		hmvo.setHm_pw(encodedPass);
		
		List<MemberVO> aList = etcService.login(hmvo);
		int nCnt = aList.size();
		logger.info(" nCnt >>> " + nCnt);
		
		String message = "";
		String url = "../../index";
		LoginSession sManager = LoginSession.getInstance();
		
		if (nCnt == 1){
			MemberVO hmvo2 = aList.get(0);
			String hm_empnum = hmvo2.getHm_empnum();
			if (!sManager.isUsing(hm_empnum)){
				sManager.setSession(request.getSession(), hm_empnum);
				//url = "redirect:/sponsor/selectCharity.td";
				url = "redirect:/sponsor/selectSponsorship.td";
				model.addAttribute("selectFunc", "login");
			}else{
				message = "�̹� ������� ���̵��Դϴ�.";
			}
		}else{ 
			message = "���̵� �Ǵ� �н����尡 �߸� �Ǿ����ϴ�.";
		}

		model.addAttribute("message", message);
		logger.info("(log) login left");
		return url;
	}
	
	@RequestMapping(value="logout")
	public String logout(HttpServletRequest request,
						 Model model){
		logger.info("(log) logout entered");
		
		request.getSession().invalidate();
		String message = "�α׾ƿ� �߽��ϴ�.";
		model.addAttribute("message", message);
		String url = "redirect:/etc/moveSession.td";
		
		logger.info("(log) logout left");
		return url;
	}
	
	@RequestMapping(value="moveSession")
	public String moveSession(){
		return "commons/bindSession";
	}

	@RequestMapping(value="setMainSession")
	public void setMainSession(HttpServletRequest request, @RequestParam("main") String main){
//		System.out.println(" main IN ETC CONTROLLER >>> " + main);
		LoginSession sManager = (LoginSession)request.getSession().getAttribute("login");
		
		sManager.setMain(main, request.getSession().getId());
	}
	
	@RequestMapping(value="moveId")
	public String moveId(){
		return "etc/idPopup";
	}

	@RequestMapping(value="movePw")
	public String movePw(){
		return "etc/pwPopup";
	}
	

	@RequestMapping(value="emailAuth")
	public String emailAuth(@RequestParam("selectFunc") String selectFunc,
							@ModelAttribute MemberVO hmvo,
							Model model){
		logger.info("(log) emailAuth entered");
		
		logger.info(" selectFunc >>> " + selectFunc);
		boolean emailConfirm = false;
		String url = "etc/popupOK";

		ApplicationContext ctx = new ClassPathXmlApplicationContext( new String[] {"config/applicationContext.xml"});
		MimeMailSender sender = (MimeMailSender) ctx.getBean("mimeMailSender");
		String toEmail = "";
		String fromEmail = "developerQuo@gmail.com";
		String titleEmail = "�Դϴ�.";
		String contentEmail = "�ȳ��ϼ���. \n ";
		String message = "";
		String checker = "1";
		
		// ȸ������
		if(selectFunc.equals("0")){
			
		}
		
		// ���̵�
		if(selectFunc.equals("1")){
			logger.info(" id ���� ");
			
			List<MemberVO> hList = etcService.idEmailAuth(hmvo);
			logger.info(" ����>>>>>>>>>>" + hList.size());
			if (hList.size() > 0){
				MemberVO hmvo2 = hList.get(0);
				
				toEmail = hmvo2.getHm_email();
				titleEmail = "���̵� ã�� ���" + titleEmail;
				contentEmail += "����� ���̵�� '" + hmvo2.getHm_id() + "' �Դϴ�.";
				message = "���̵� ���۵Ǿ����ϴ�.";
				checker = "0";
				emailConfirm = true;
			}else{
				message = "�����ȣ�� �������� �ʽ��ϴ�.";
			}
		}
		
		// ���ã��
		if(selectFunc.equals("2")){
			
			List<MemberVO> hList = etcService.pwEmailAuth(hmvo);
			logger.info(" ����>>>>>>>>>>" + hList.size());
			if (hList.size() > 0){
				MemberVO hmvo2 = hList.get(0);
				
				//���� ��ȣ ������
                StringBuffer temp =new StringBuffer();
                Random rnd = new Random();
                for(int i=0;i<10;i++)
                {
                    int rIndex = rnd.nextInt(3);
                    switch (rIndex) {
                    case 0:
                        // a-z
                        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
                        break;
                    case 1:
                        // A-Z
                        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
                        break;
                    case 2:
                        // 0-9
                        temp.append((rnd.nextInt(10)));
                        break;
                    }
                }
                String AuthenticationKey = temp.toString();
                hmvo2.setHm_pw(AuthenticationKey);
//                logger.info(" �� ��� >>> " + hmvo2.getHm_pw());
//                logger.info(" ��� >>> " + hmvo2.getHm_empnum());
                //���ο� ��й�ȣ ����
                boolean bool = etcService.setNewPw(hmvo2);

        		logger.info(" bool >>> " + bool);
                if(bool){
    				toEmail = hmvo.getHm_email();
    				titleEmail = "��й�ȣ ã�� ���" + titleEmail;
    				contentEmail += "����� ���ο� ��й�ȣ�� '" + AuthenticationKey + "' �Դϴ�.";
    				message = "���ο� ��й�ȣ�� ���۵Ǿ����ϴ�.";
    				checker = "0";
    				emailConfirm = true;
                }else{
    				message = "������ �߻��߽��ϴ�. ����� �ٽ� �õ��ϼ���.";
                }
                
			}else{
				message = "�����ȣ �Ǵ� ��й�ȣ�� Ʋ�Ƚ��ϴ�.";
			}
			
		}

		logger.info(" emailConfirm >>> " + emailConfirm);
		// ���Ϻ�����
		if (emailConfirm){
			try {
				sender.sendMail(toEmail, fromEmail, titleEmail, contentEmail);
			} catch (MessagingException e) {
			 // TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		model.addAttribute("message", message);
		model.addAttribute("checker", checker);
		
		logger.info("(log) emailAuth left");
		return url;
	}
}
