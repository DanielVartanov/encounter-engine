/**
 * Created by IntelliJ IDEA.
 * User: pasha
 * Date: 19.10.10
 * Time: 16:24
 * To change this template use File | Settings | File Templates.
 */
/**
 Code generator
 */
function generateCode(symbols_set, code_length) {
    var result = "";
	for (var i=0; i<code_length; i++) {
	    result += symbols_set.charAt(Math.floor(Math.random()*symbols_set.length));
    };
	return result;
}

function generate(item_id) {
	var symbols_set = "abcdefghjklmnopqrstuvwxyz0123456789";
	var code_length = 10;
	var generated_code = "";
	generated_code = generateCode(symbols_set, code_length);
	document.getElementById(item_id).value = generated_code;
    return true;
}
