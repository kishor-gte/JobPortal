package in.sp.main.Controllers;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;

@Controller
public class PaymentController {

    @Value("${razorpay.key.id}")
    private String KEY_ID;
    
    @Value("${razorpay.key.secret}")
    private String KEY_SECRET;

    @RequestMapping(value = "/payment", method = RequestMethod.GET)
    public String getPaymentPage() {
        return "payment";
    }

    @RequestMapping(value = "/createOrder", method = RequestMethod.POST)
    @ResponseBody
    public String createOrder(@RequestParam("amount") String amount) throws RazorpayException {
        if (KEY_ID == null || KEY_ID.isEmpty() || KEY_SECRET == null || KEY_SECRET.isEmpty()) {
            throw new IllegalStateException("Razorpay credentials not configured. Please set RAZORPAY_KEY_ID and RAZORPAY_KEY_SECRET environment variables.");
        }
        
        // Amount provided is in Rupee, convert to paise safely handling decimals
        double amountValue = Double.parseDouble(amount);
        int amountInPaise = (int) Math.round(amountValue * 100);

        // Mock flow for local testing if dummy keys are detected
        if ("rzp_test_YourKeyID".equals(KEY_ID)) {
            JSONObject mockOrder = new JSONObject();
            mockOrder.put("id", "order_mock_" + System.currentTimeMillis());
            mockOrder.put("amount", amountInPaise);
            return mockOrder.toString();
        }
        
        RazorpayClient razorpay = new RazorpayClient(KEY_ID, KEY_SECRET);

        JSONObject orderRequest = new JSONObject();

        orderRequest.put("amount", amountInPaise);
        orderRequest.put("currency", "INR");
        orderRequest.put("receipt", "txn_" + System.currentTimeMillis());
        orderRequest.put("payment_capture", 1); // 1 for automatic capture

        Order order = razorpay.orders.create(orderRequest);

        // Return the full order stats as string (it's a JSON string)
        return order.toString();
    }
}
