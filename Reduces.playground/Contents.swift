import UIKit

func morganAndString(a: String, b: String) -> String {
    let pattern = "^(.)\\1{1,}$"
    if a == b,
        b.range(of: pattern, options:.regularExpression) != nil {
        return a + b
    }
    var A = ContiguousArray(a.count > b.count ? a : b)
    var B = ContiguousArray(a.count > b.count ? b : a)
    var result = ContiguousArray<String>()
    result.reserveCapacity(A.count + B.count)
    
    if a.count != b.count,
        String(A).contains(String(B)) {
        // a: "ABCBA", b: "BCBA"
        if let li = A.firstIndex(where: { (c) -> Bool in
                B.first! < c
            }), li > 0 {
            result.append(String(A.prefix(upTo: li)))
            result.append(String(B))
            result.append(String(A.suffix(from: li)))
            return result.joined()
        }
    }

    while A.isEmpty == false || B.isEmpty == false {
        let ca = A.first
        let cb = B.first
        if let ca = ca, let cb = cb {
            if ca < cb {
                if let li = A.firstIndex(where: { (c) -> Bool in
                        cb <= c
                    }), li > 0 {
                    result.append(String(A.prefix(upTo: li)))
                    A.removeFirst(li)
                }
                else {
                    result.append(String(A.removeFirst()))
                }
                continue
            }
            else if ca == cb {
                if A+"a" <= B+"a" {
                    if let li = A.firstIndex(where: { (c) -> Bool in
                            cb > c
                        }), li > 0 {
                        result.append(String(A.prefix(upTo: li)))
                        A.removeFirst(li)
                    }
                    else {
                        result.append(String(A.removeFirst()))
                    }
                    continue
                }
            }
            if let li = B.firstIndex(where: { (c) -> Bool in
                    ca > c
                }), li > 0 {
                result.append(String(B.prefix(upTo: li)))
                B.removeFirst(li)
            }
            else {
                result.append(String(B.removeFirst()))
            }
            continue
        }
        if ca != nil {
            result.append(String(A))
            break
        }
        if B.count > 0 {
            result.append(String(B))
            break
        }
        else {
            break
        }
    }
    return result.joined()
}

morganAndString(a: "YACA", b: "ACA") == "ACAYACA"
morganAndString(a: "ACA", b: "YACA") == "ACAYACA"
morganAndString(a: "ACA", b: "ACA") == "AACACA"
morganAndString(a: "ACA", b: "BCF") == "ABCACF"
morganAndString(a: "BCF", b: "ACA") == "ABCACF"
morganAndString(a: "DANIEL", b: "JACK") == "DAJACKNIEL"
morganAndString(a: "JACK", b: "DANIEL") == "DAJACKNIEL"
morganAndString(a: "B", b: "A") == "AB"
morganAndString(a: "ABACABA", b: "ABACABA") == "AABABACABACABA"
morganAndString(a: "YZZYZYYZZYYZYZZY", b: "ZZYZYYZZYYZYZZY") == "YZZYZYYZZYYZYZZYZYYZZYYZYZZYZZY"
morganAndString(a: "ZZYZYYZZYYZYZZY", b: "YZZYZYYZZYYZYZZY") == "YZZYZYYZZYYZYZZYZYYZZYYZYZZYZZY"
morganAndString(a: "BCBA", b: "ABCBA") == "ABBCBACBA"
morganAndString(a: "ABCBA", b: "BCBA") == "ABBCBACBA"
morganAndString(a: "DAD", b: "DABC") == "DABCDAD"
morganAndString(a: "YZYYZYZYY", b: "ZYYZYZYY") == "YZYYZYYZYZYYZYZYY"
morganAndString(a: "BBBABB", b: "BBBABA") == "BBBABABBBABB"
morganAndString(a: "AAA", b: "AAA") == "AAAAAA"
morganAndString(a: "DAD", b: "DAD") == "DADADD"
morganAndString(a: "BAC", b: "BAB") == "BABABC"
morganAndString(a: "BAA", b: "BA") == "BAABA"

morganAndString(a: "EHNYCHTZWXSQQLVTRXTDZWOQDCJSCVQMZBNGYNLYMJVGCGGPZTZAWEZYXDEJAKZTHEIOXRIUFHVPSLQFGSFOBWDPZIXWHXUVMDWUXYIQRQPUOUAQNZSGWKWMGZFMSAAYNEGBEVLSZWUOAVKYITLQRFXZRGCIJUSNLXRDCCSOKJJSWRMGPCOYYWDOADHPWFRDDOSPLJTUFFHWIGJODUIJFMDVQBDQOLDWIPDWKXHEUAQZTBDSAQIPBEMYATVUJFWSYGDPRIWWAKJDDOWUOZINGZTANILADLQNIGXLAAQOZKTFYBMMIZXBMKPYOTUXIZDZJUJJRJGFTWGLEZYEITSEMQXWXOHCKGWMACWEBTCOWNTWHUAERULYXYEVXXIYXJCWKUZIKRKLYEUTZRGAJOHMDKOILCQUZAIJWTOHFYUDIROBNFPUPNHLJXLPYWZTVPOVTEKMRDQSEXKERABUSOFSHPSZBMKIJLGHDCKXTRPJTAWANWMDCOAOGQJGJJQLXLKEOPWYMOWYSQEQVBZTYLDEQDRUYRQXPFTCYHJWEMTGMHSDXOQHDYMJELCXTMLSDRSICVIJYCONYHYJWYNHATQILCWSBQRYEAMEYQFQESNBGOKUUDJQKZMMTOMJGZPWMMNUVKXWSQIINRPJXBYQENUOWKJXOZLGPVZISIFWYBCUQRDDNLUCTVRPDIOEERWQVESZOOSOBJBJCGOLSZPNRNALICUQUVZHSISJSICGZKZXGMNJCRWJNAEMRFIKVEMMVTSLBMSLWUJSELZGMASAAXJLGIPMINUCINHJLWFQKFJIPTYKYXUSGCAKRRYXDWGAPTFHXINNHHCVQKHEGSWDYUOWGIWBLKNHMVADYRBCMLOUYRFUATLRWNVYRYNEYLPGDFIDGMFKCFXPCPDPGZOGICCOVRHASWPZRCDGIEYWNPHFQWPIBMVPRKEIKDGCQCKSIXQQMBARUXYAVEOGFVIRADTNMBXYTGYOCOFWSBRPOIXLCVZTIERORPCJXGRPHFMTDJEELDNFTLNKWPCJKHGFRVQMDQDQJPRNTTEKGYDVKOQIGIQGLPUHVGRXXTXNASXZSGRZDCSYSECAFPMGYPGOKMYHBQPFDQLTDFMVYTLEFZFANDHODFODLSEEFXVVFECAIQHBHQCOFXXUJURJALLSDVMTFFWFVMURVFGSPOBUAPHECCYEVIUDPXOAAGWPJDGXGFDAXFRAWWJUGQRWAUMKLYFCMIZBECTDTLQCNMSFKOCCBXHUECJHSZGQMGIXDDMQHFMJFOYQANUAGIXWPOFABJVZBFFAJWXDYRQHYHDOCIFLNLUXZIWHYSVHMBSHPQOFKUYYORFCSBSCHICJGBHUHZRPMSIOXOFZTQYSXJYKZYHRFSYUAUXTRXBMZBVGQYDIXPKRWIIUXOAPUSVRVBTWUUWDQMVYTRWTXGUQVGNTPUTFOMPULYNTEMFIBURWTMUGLKFKTRHWQYORCCPZXSQMHMUFUNBTVVQXCJDHEAEOLKIWWDATNPZRKZKHRDLLEOZBNNTKBWCRFYGKUSMVJJQJPLIVRZLCEGWARXPCTWRCYNGXSZKOINBWRFIQMVMBSIWLFAJJOGYFLEQZTRLDKOSRDBJBBGCENERHXNWUHSSTKLCBHLLLWOFGMSQADVTQREFAMBFVKWPQJCQBENHZWNNAGDFPDGWXSZDJWXHIRSOFGUPULDMREIERSMRLIZXRPCTYMHXDMODPKCZSTGUGGBPTOJPTKYMQQEJQAJCAJRTLVEAWWJSMFSOMIPICKCQASTJKHFLWFDNMZWFWCDTSDYVFFVTYQAXWKLCNKLNVYXQPUOOLHUMMNYRTYROGQKBUZPZWNBVDZWEHQRGNAYDPIQQFZWBQJMTZPETCCVRAHCQRMGBMUMJRLCMMRQVEVQRZXNSGVEHDJTFKARJIDYLVUZXCPIZRFBRQYGHCSODWGYBJZASEPRTVYJTRQZKPWABJPZLRYZGTIYXXKUGEPOAGJTFTPDVYYPUAFZKVZMDYMKQUYGSJXBFPBYUXZAGHLVTSUVRPROLTTMRTIOLSWVIDGPUWABDNIMBUJFPXGJALVKIKACLFBLYNUXVOZPLXTGSOXLSOLZAMJBTULOOVQXQEDZBYPEKOMMVRTWPKUYPLPGJPDPEPGRQVWWCGZVCJLMLMSVNAQVCGQJKGUQLZWKRODZVSOHVNORSVXWIIYDZIAOWYRNALTZGQQXONIAYONNUCCEPBTOURSHZMDYDVUEWVOKRDSMWNRIULIKREOSEFNWCZIBHXHAJMWXLPBOMQIHXESUTALQDOPRQOPTEVXPVIIGWPULOEFDXCVGRUTRRUNTKUIZSPWFNUNDZTQXDPPCOSQRXJASFLQJEYTTKSMQPEHJMRJDUUFAQUHGLQEONTXFVHTIKRKCBLVXRLOAVDXMZRVHQKSAZQHBEMQIGQXTTCTDFERABGJORICJQYUGEQCSRYGHOSJXBYMTTKGPNMNTQRMRNKDVWNTBXFZUMZHGJUTCKKPYHLNRJPHTWXWVJTFXJNTZVWQQNZKIVUSQOTFSYGLJANTSZTLWPLMVCZBYLOBQVUIZVPLBYGFAERMWJVWIYZWORLVCXILQNLZYOSEMDUFJNVWQHMLQJQYCACZPRIRMHVCTCOSQDOPEPILXDMFNZBUSHUPUTDNZFZMNCBBMWRROKIXVCIYBEACLYFORTKIRAHNVXIDMCVEFZQYFIWTDEGJFEVJWTCUNTQQPRVMOLMMUZWMLCEJHJHPCJKZAZYWPWWTLOQBUXOQIJJPLEEAVAODLRYHSWYKJIJEWEQCXPLJDYQHSEMRRZIWYDNHQMNBNYFXPYRBEYOUGYKJGKKBLIMKGHZIZXXKDZMWGQYEHQNINKERCUWPVULZLOWRSQXHGNYKESNFIZDVANPXMVMQUKCYRIJRRCZKPWPLNPBIHQAWIJWEGPKHRXAVVRYRIDGWZCVMIIKUTQEBUNNEWBWVHWDYQBMTIIVFBWYWQOHPPBUCKGBUMFEOWXYNWEJKEYJPBUTWLIBJRQULVWSOHHUZYWZOBTYRUAROBWJXZIXTVGLNKKFGAAYRIQLBSVTNRREGIXKHXBMEOMSIDRYEMUFZTMSYZATTGXJLOXPLYJNOJWPIJJSNFXBENJNILQZKDGTVRUCKKTBYMQLDWVZJCTTKEAIVOVPUSNXPAMIZSSTYJQRXWGCHKNUIDRGBKLDQQOEHVEVRLCKQGRFRJWLHURSNBHHLAHJXCHHPAPGKNMERSLFNFAVXHZMGADMKSFPEQWCMNADVYHMHAMZCCZXCSQRUJNMKLWNCOQGRANWRZGWQYPVHNFQOQIXNJMOSSWNXZUZQJULNHZNMYMZDJZFHIVAGUPZYUTRAEROCMXGMMPTZXDDRWMBPVJOWUQUBWUHOKHJBSPVYTVVNIHGNMBHUBZTYCSOVJTKSBRJTAVCILRFUHAWORDCGHODNRMRXHGNPBAMXFADHKAIFEWACDSXLDWAOZQDOOZYAFIEDWOWKSTSWVSKJGMGGPNDRITPAQCKLYACAKXGQMGSFHEZNBWWBCJNXBAPBBMVXNPKDRVZKXGJCXOXUJZZMZIKBVZVOZUJPWLKBSGGWBOISHEHLWEKRONPVHLWKCECXXLDRVRRDXDOLTPHIKIXUPSCXTRSVBWNQPSQHOBAIFDAJSTYVIDREDDSAHXEUSWAOMMTSGGUKSILWKYMKLHWZAPBMLEVHVWCYPYKQPIHENOTQJNNSIJAVQEUWFFMVZJNCVZMVEJDGUMBWZYNJBOQMAWBVNJXCZNLMUFRJQPWHBAPDQXGUADKOTAWHYQQHRAUFLXRTXNNKXYWZYPCMUVOWBORZGOUZHBVVKYPTHHDCZDRPNKBUKSTAEIOFEBWSREMPCTTZYDUCHYWRLSOBGZOQUZFDZYLWQQSRZMIXHWWRAMGIMUXWOZXCIRMGXPQINXNVEZTZAELZEHNKSERZHEMKRGXBMKJYMDVYAUZYRTNFQEZIBGUVYLKTXCQCNEUSFMGQRUQNMQZEZYDXIMINYFPLYKJBHQKONMZCKTXSVPWYJVUSZBGNFGFETFWYPJOYCOUKTBGCUSAAIEJEMISGJVHAFYKTRELMEZYXELSYWKIKZMTJKQDQRPVPKBNCDXNSKNYMGYCCTXONNMLOATKJSGEPQUWSWRXVZMQTINKXFPBLKIUHSSFEBPSHDVXRJNWZMCQTZFGODTBKFUTWGQCASNARKZVSAJZMWRCHPOXDPTLZVZXBYJVZDYMXUJMAFNARTSKCGZVMHFHOQDNUFTKGOJBJPIIIAKBHPZUFCQGVFUZYKMEIYEZSGDUXDCHDNUJCWDCLFAVSNWHZWWQZHUYWOUSAPXOSOXDVOWQGPUKWBLJGNOQPYOBXFZAMKJCVITKOQGWBTCSFMFJAPXUAENMSGVLXWMPVOIPCGMDQRBPNOJPVRQZCWNYMHFQFHPDLMCZNSWKRWSIWPXPYWVJAAUSFGJQUFGZTCLXGVGRKLMVTPZNCEBLYEKYYXEGVFJSDDFPAUIPISFFEXWJOXHGOYDXCHFASQHCIUGBHRIZKCEZQMYVRWGLUXCPTVMPEWSWYAMSZWDZNFWAAKRRDCKVWQNAFQCTCPBPURDODHWMKJXNAGWYHVNZMVPXHSSDHSATBVZGCXBYCMMZSARMRANMTGMWDFUFNJDVLVEQSVGZCKYFJYCYVBYFXOCQCLZKNCTJXKIJWXXXOXZGTNMDLPEXWTFFHYYGVIGAEQITLKEGBYEHIMTZVLFBQNRFKAXJKMUGDWCNBMSWEIKVGPNXMXIMBBFUWYJWDAZCXICWPXXHCHONTWEAOYJGQWYOKYJXOQTUFKDXZWLDUSCBQCJCSYCWRAEXZPCUKHNCAQQBAVFWUEGKTTKRXDGKAXHFAQQUGUOCYSENIDFINGGKFHRDFSGPRCNRMJSQGLGEAGRYVUEBKNPCHPJARWLVAMWXKLLCIEVGLQURKGELWAVMOEAQPTETSXDIWHTAWUHYDSWPBSBXSMILPGRJOKFWVFRYLLDZSNEODKXLCUBVCPZUMVCRMOKTLZWLUBDFVXDWXJQAFTGWPRHKSJVUHFEECTVSVSQWPFUBKNOEUWBEAYTWZLEBCFSBEHXRDGRVKDTBWBGEFHRWEYGLVOLNNDRVEYZFAKHEMLZNXIKCXOMMMNKKPEDCQAMNPHJZIDPYOFCZSAEXSDKCFADQPFNZOLXXPWHZQXZFEPXKVVZBDNFGOECOEEBGQKZRYZVNRRMACXGCZIKRXZFCPREJDGWDGDQWAUONDVIZUAHGWOEKFHZYFFWYGTTUWTHZMOSHCOAZAUQVGXUDNBDKZXLFRLJOOBBZWCJDOJVRQDZHOKWRGUIYLSXBLOYLVFCQXSGFKKNKCCRUYKHVSMMEGRZQUPOSCPCPXULPVHHDLJVKBZEQXPDELQYHAPNXPODAIXCHDDEZXSNHXFJRVYKYHPWWXIKKADPWHYECYZHRCPETXJRPVCJZTJAMTEVEWBOJJIHLMFEKRSFWOIHDPVWIEDCDCCWFXCUQWMVCSALZCFNSIMPAMPXPFFLJLQMOUKBMJPRCPZKGIIQRWAGDQHMBGRUNWCNPEENIMDFHNIYESXOCNODZHNWGWKDYNLRWVDGDCXZJWJFJAYOYMKGQAUGOUNOBMOXHYXIWXDTRRVZYONYDMCGXRXCSWMTFRHTDEPHAWRSHCFFJHQCOXIKFJDUKZEEFDUVMKIKWQFGEIRDRDCKNOOPZBVSVJMVCEIIHBWLPZCHICDXFYLWOTQNZOUEJRWXGEYUJKXYOHVQHOOLCADPQWCMKDZFCVVKRZOPUMAQYTWTNBLYIPJGZAGAAUZHMBNOAJWGVDUERVYKSCJTDLUZMURSWCBMBCWOMMPRDENOWUVGYCMXGKQAPOJWHVJXDQSTIVXEQQFFHRRRDIYOYPBXCHHASFSQNOXPMECLWXLWDVZNRBZPKQKWXEYBUYJIDSBHXRHANOMYGJLBXQRKXNDAYAKYYYFFYOPYURLNXTWUHZERXDAGNZICBABUDCUHIZOTKPAUUIQCWSXJKHBCYEEGHNWGJYKKNFMYXJOGGBJUFYMZUTQSZBIXQJEWXMLUUBTMPADMKMTPNRHCQZGKJMCEHNECPCNMNBMGLUSTXEYMPRWQSIYOBVQACAYHEGZZBUQAETEGHBNEWWEHJIEEPGHTPLCCWTFTRNGJFDNYZUFAZHROOTIEKQHRDDBOQXMYZMWUPDRCJYBIXGPRVUDAIXJKUSYSSGAOQCOAWXDDDGNRNZQBCOQVLENHJXLWJGVFNKLXUJYEOHJGFAMGDNZCANNYDNWBBZWGYHAPSVUXERUJRQPUUDXJBCQZKJRUFCDNRSRZZLNOCJJRQJORFIBXKCZBZKCVIVZJXMBUCOPUEICSWINZGHNUGLEAZMJRTKBEDI",
            b:
            "XTGNVWTPXMSKFJVFTKRLYSUHJHDDYHWWRNPMUEJDLUZIOYQGPDSHYIFPXPCFWRLTGMNWVETLCHLZCGIFAKGUQNCTISRVHHAJZZATQERCUHRBTIDGRDTDADKRVLWAWKXOZSWSXGSUDFHINWAYZIVCLLPQAFCYGCVKKUGFUCPTDCBIEFYWDQLZBIWTSMDCWEGHXCEMAVAOGHRBTDPYWVZJAYBRSBBNVMEVJPIDCPPAFOXBOBBYETZUUIMGUIHWYTHROOQUSDHZKLLVQPNNFFZFQTFQNYLKCDZTDIUHKBQYHAQCPGXOQFFFQLEAEBVYCADCBKDWSSPEPFYZVKWLWYGOMJWRFOJQTOZBUXTHMEVNNZBDARRJUREQPZTLZCRSARAMDCESBASPDDCHKHUFFRFHHRWLHIZBARDVXRITNTTRWIABSICXREDKYJMRREBSRYRRUZRUPDYSDBFSHGSJHUEDPBNTSKSLZUTTDUFQLBVQDNMQZTJWUERNMKCRLFOAVHZFXHZBJEVXEIFJAZURGVMBFYJBJQNFXFMOHUZTQSDUELIUOYOGFEZMLYMPJCFJIOLRZSTTWTTWRBZJJDAJQAONMLYZBIEDYUZMQPDGVKEBYTJFEIYTVFTDGDKLDUFLPMXHNSDMPURWXXMEDCZBYBZEIVYDSAMPHIFVWDMHOBLOHUMEZBWZDJKGMRBCNJNWSBATONEBZPLTMMFDGUZWCOAEOXSATWYADHYZQZJNTKMFXUTDCRLLPLHFRZQITITDZTNEYAVUOVSNRVZLODUYMENXVIYNBNHDIVFXTPYCWIWGAGVSYTKMXAAKSWVJWQQUAFOUOJHTBWFBTOXXQFYXYDRSAAFEJGUKVBPNXJUGPBAEBDDPCDXNJVUWDUFJYATVDAEVTGVALAIZNJNOTZVUMPPPEJSDBUHOVLYDVLUTQJRPBJLILDSOCZYZSJFOHYHUFCYDYYTFJWIBIVJUAHCFPJPCDYDFEXBICTGNIIBIGNWDXJIQHDCYFADTJYSDGCHFUVJODFMPPOUPEWQUQFBWHJYPYXNEHKJYDVCTWUKZGNFCMAXWRLXJOVUCGVYYLAHNCNAVRXFAYWLFWEGXOEATKJBQEWDCKXLCYAQGELTISLJNGNDMSDIEGTZDJEIVYGKUITBMTDEQNARMDWBLOSQORWPUKJVJDNASJKSQIGCVHDNWUVCBYUNRSILMPVBBBYZCGEZLXKIBAEFSXOCWGPBKUCANOGYPIMRWQZHQCVMYQGXXBQJQEKMGDZZZRRCPMDEDKYXLZQOUDPEZVQWAIXDNBQHIRWPBFQRVHHKIWCNQKYEXPLNVMBKZBBSHVWMTRJSWGFTSZLDXSXUCSMPRPIILOXBHSPXZYDDLYUQNCLNFUVVOVPKWOCGGRZOEQAFPFQEFOKMITPTWQOJJQOAFNDYPPWSXVBVLQPDURHSOSUXKIHBICWYECZJWOSESPIERXVOWHVQFFDPSIVWEMCODLUKPJRYVLPZOPLGWAWPCRWSJTQJFHNYVRUKDMWHXNWFWNORKXITBSGQLKOJXONGPCJUHYKSCRBOOCBPBSRNHEHKSIVFHRBKTOVZTYIZPOAJZKJEXUCTUIMFTHNSGIVQTCXACILYTKLFLKBOCXHKLRFCLJMAMUCCOIXLAATDJTAMAVMWLHZXZFRLQMCYUUIVYWCLVSOWMBJFPZDEBSCWMNPLCPVJPLCLNAMLJWXOBZKWVXZUSWDCVEMEYCXKLKTIGXGXAORRISJTFSMYUUKOELSWWZLQWXWTKFIEECPXJXKFFQXGCFCHUHJNOBZHPIELFYLSCCDEKWOVZYWBMNUYZYBTBYKEJUAOLVGHVYSLHGLJKFONWUSRVSKYYIQULSXJDYTWKQZWWMKTJZDAPWXHSYNXFQSABTUULKDWRADFZMUDWNYYSXOFUYJAGWSXHEWLAPPZIYGAVYNOPQQRXGXQBURVMCENONTHCRRJTETDCLKTCDAOMRMJJKSRHBQRDDUUNQTYFGYMKKYOJOZPCTTRUPJBSVUAWDRLAOCRWQUHJIRHOEEUZIUJCSUXZCUDDLJPKIJDKHKBSADRUYGFZOWPUIYEIKMPTCQRHRSERZEYQLCKOYAYRVSKQZXWEDWYHZVQTZSUUMCWNCCIYHZPOTWBJGRAJQYXSEOEXXSOXNJKIHPPOSYVOOTASCHQGKGJKGLYJUOMWPDMXAJAUXCWJIGMFBNRGPYNTODQWFLAMNMDUKFFETUAMQDJBKJELHSYIIOUAGJBWVXIAXEDYZHRJZFDEQKFRCMHKTYCLPZBDMJHSQKDJFTLPAWROLJWGBWMDUIBQCBBULBOQBUELSLXVCMKNKNQJSRGKPVTICAVOQHUGGQKVDLLFJXAVEJEZVTUQHIPZOIMOCMZHGZCWWTBNFTWIZWSMNLENDMKNDVHTOPHRPTKQYMTRMCPBCXFOSASJGBVHNZYPDVOGFBAAACDAWYGFEEJZGYHVICHFTOOFRNQBWFCEXFBMTNWVBYZEZGLQLJWPKGIVMWNFYPCOEGKXXDODGBLOERJQNBTYYZHEXAPQANLKNISBFOAXCMIXTJKHFEALTBWPCZLWTHNQKQFUBORZELFSIKNQNNPCVCMERRLZIZJAAFKKJTAAKTIZAOLEFOLJWVOMSKDWKBKYSMSIOVKNWUVWXRIFMOQLZGEKQXMMSFNKBMRWTOQHQTDMICVKJPBUUAVAQRUZBHRACXSUVHTKNUCZFMXCXWJGSLIMPNGKSLUHTMZSGOHKVYCISVOFHKIQVFFHXFWXHPRRIVQNDYZBIKRHLIHBNAGDFXRTNPAWEIRBSDKGHQIZVVJCWMATJNGJDFWJYAIIAKVCKERNWKWQPAMCEVIGSIAYDBXWWKVBDYIAZLCZLXJNRKCYDWTRSAQRXNMCUKBMZIONMAUOZCYXQCSQIZNGTCMAFEDMHNRBXVAMDONIHHJWUWMKTDNBJLYCOTFAIPXCMFFUDZVUJUJQWHSXQWJZVZSLOCABVMVMXOEXPSTRNVBSUDFVABUTQYTNZDKIMXKUGGSOXODTUITPTDYBXMOJZLDZOPCNDVGQAMBAGURQCXQSUEHZZRDTSCUUNDTEHNFARXAPNHNHLQLPLTVVYYBKEWAOUDTKSMXRQTIDEWVQZCBSHMQWJPFXQWRVDFSQULKVHAEFRABFMAVKJQIHIURRCIOCNFFYKNQUCJPAROWBESUKYEWKLPQGDZFFTKWHBGRXELNCERMJNNDUKVWDTZPSKDMFSGJOOQKBVQRSNLVNCJKEICCRUQTKLBVGYGFLDERSDDSKIRVHYYABZQAKSBUFLQOSLMYWZOKOABPMBFUHWTYGTAGKOMTBNVJGTXDOJRXEVKVADIZODGLXNZESSLLRXNFKJVQKDNIUNJPOFWWZBWSNKQKJMDRWGPCFAWKYKZWUDQCYDSXSYTJVEOVJZOGCNQYOLIMWBFZAJIWOAXENANJVQOLMVLTBFCVHKFGHVSBQUBUGZSXLLSVCVFUXYPPKYRNIXJTAGJMMRQNQYFMRROKIUSIWCWCAPALNMAGGKVQAOXBHOOAVGPZJFXWXGMTLNHPZSM") == "EHNXTGNVWTPXMSKFJVFTKRLYCHTYSUHJHDDYHWWRNPMUEJDLUZIOYQGPDSHYIFPXPCFWRLTGMNWVETLCHLZCGIFAKGUQNCTISRVHHAJZWXSQQLVTRXTDZWOQDCJSCVQMZBNGYNLYMJVGCGGPZTZAWEZYXDEJAKZTHEIOXRIUFHVPSLQFGSFOBWDPZIXWHXUVMDWUXYIQRQPUOUAQNZSGWKWMGZFMSAAYNEGBEVLSZWUOAVKYITLQRFXZRGCIJUSNLXRDCCSOKJJSWRMGPCOYYWDOADHPWFRDDOSPLJTUFFHWIGJODUIJFMDVQBDQOLDWIPDWKXHEUAQZTBDSAQIPBEMYATVUJFWSYGDPRIWWAKJDDOWUOZINGZTANILADLQNIGXLAAQOZKTFYBMMIZXBMKPYOTUXIZDZJUJJRJGFTWGLEZYEITSEMQXWXOHCKGWMACWEBTCOWNTWHUAERULYXYEVXXIYXJCWKUZIKRKLYEUTZRGAJOHMDKOILCQUZAIJWTOHFYUDIROBNFPUPNHLJXLPYWZTVPOVTEKMRDQSEXKERABUSOFSHPSZBMKIJLGHDCKXTRPJTAWANWMDCOAOGQJGJJQLXLKEOPWYMOWYSQEQVBZTYLDEQDRUYRQXPFTCYHJWEMTGMHSDXOQHDYMJELCXTMLSDRSICVIJYCONYHYJWYNHATQILCWSBQRYEAMEYQFQESNBGOKUUDJQKZMMTOMJGZPWMMNUVKXWSQIINRPJXBYQENUOWKJXOZLGPVZISIFWYBCUQRDDNLUCTVRPDIOEERWQVESZOOSOBJBJCGOLSZPNRNALICUQUVZHSISJSICGZKZXGMNJCRWJNAEMRFIKVEMMVTSLBMSLWUJSELZGMASAAXJLGIPMINUCINHJLWFQKFJIPTYKYXUSGCAKRRYXDWGAPTFHXINNHHCVQKHEGSWDYUOWGIWBLKNHMVADYRBCMLOUYRFUATLRWNVYRYNEYLPGDFIDGMFKCFXPCPDPGZOGICCOVRHASWPZRCDGIEYWNPHFQWPIBMVPRKEIKDGCQCKSIXQQMBARUXYAVEOGFVIRADTNMBXYTGYOCOFWSBRPOIXLCVZTIERORPCJXGRPHFMTDJEELDNFTLNKWPCJKHGFRVQMDQDQJPRNTTEKGYDVKOQIGIQGLPUHVGRXXTXNASXZSGRZDCSYSECAFPMGYPGOKMYHBQPFDQLTDFMVYTLEFZFANDHODFODLSEEFXVVFECAIQHBHQCOFXXUJURJALLSDVMTFFWFVMURVFGSPOBUAPHECCYEVIUDPXOAAGWPJDGXGFDAXFRAWWJUGQRWAUMKLYFCMIZBECTDTLQCNMSFKOCCBXHUECJHSZGQMGIXDDMQHFMJFOYQANUAGIXWPOFABJVZBFFAJWXDYRQHYHDOCIFLNLUXZIWHYSVHMBSHPQOFKUYYORFCSBSCHICJGBHUHZRPMSIOXOFZTQYSXJYKZYHRFSYUAUXTRXBMZBVGQYDIXPKRWIIUXOAPUSVRVBTWUUWDQMVYTRWTXGUQVGNTPUTFOMPULYNTEMFIBURWTMUGLKFKTRHWQYORCCPZXSQMHMUFUNBTVVQXCJDHEAEOLKIWWDATNPZRKZKHRDLLEOZBNNTKBWCRFYGKUSMVJJQJPLIVRZLCEGWARXPCTWRCYNGXSZKOINBWRFIQMVMBSIWLFAJJOGYFLEQZTRLDKOSRDBJBBGCENERHXNWUHSSTKLCBHLLLWOFGMSQADVTQREFAMBFVKWPQJCQBENHZWNNAGDFPDGWXSZDJWXHIRSOFGUPULDMREIERSMRLIZXRPCTYMHXDMODPKCZSTGUGGBPTOJPTKYMQQEJQAJCAJRTLVEAWWJSMFSOMIPICKCQASTJKHFLWFDNMZWFWCDTSDYVFFVTYQAXWKLCNKLNVYXQPUOOLHUMMNYRTYROGQKBUZPZWNBVDZWEHQRGNAYDPIQQFZWBQJMTZPETCCVRAHCQRMGBMUMJRLCMMRQVEVQRZXNSGVEHDJTFKARJIDYLVUZXCPIZRFBRQYGHCSODWGYBJZASEPRTVYJTRQZKPWABJPZLRYZGTIYXXKUGEPOAGJTFTPDVYYPUAFZKVZMDYMKQUYGSJXBFPBYUXZAGHLVTSUVRPROLTTMRTIOLSWVIDGPUWABDNIMBUJFPXGJALVKIKACLFBLYNUXVOZPLXTGSOXLSOLZAMJBTULOOVQXQEDZBYPEKOMMVRTWPKUYPLPGJPDPEPGRQVWWCGZVCJLMLMSVNAQVCGQJKGUQLZWKRODZVSOHVNORSVXWIIYDZIAOWYRNALTZGQQXONIAYONNUCCEPBTOURSHZMDYDVUEWVOKRDSMWNRIULIKREOSEFNWCZIBHXHAJMWXLPBOMQIHXESUTALQDOPRQOPTEVXPVIIGWPULOEFDXCVGRUTRRUNTKUIZSPWFNUNDZTQXDPPCOSQRXJASFLQJEYTTKSMQPEHJMRJDUUFAQUHGLQEONTXFVHTIKRKCBLVXRLOAVDXMZRVHQKSAZQHBEMQIGQXTTCTDFERABGJORICJQYUGEQCSRYGHOSJXBYMTTKGPNMNTQRMRNKDVWNTBXFZUMZHGJUTCKKPYHLNRJPHTWXWVJTFXJNTZVWQQNZKIVUSQOTFSYGLJANTSZTLWPLMVCZBYLOBQVUIZVPLBYGFAERMWJVWIYZWORLVCXILQNLZYOSEMDUFJNVWQHMLQJQYCACZPRIRMHVCTCOSQDOPEPILXDMFNZBUSHUPUTDNZFZMNCBBMWRROKIXVCIYBEACLYFORTKIRAHNVXIDMCVEFZQYFIWTDEGJFEVJWTCUNTQQPRVMOLMMUZWMLCEJHJHPCJKZAZYWPWWTLOQBUXOQIJJPLEEAVAODLRYHSWYKJIJEWEQCXPLJDYQHSEMRRZIWYDNHQMNBNYFXPYRBEYOUGYKJGKKBLIMKGHZIZXXKDZMWGQYEHQNINKERCUWPVULZLOWRSQXHGNYKESNFIZDVANPXMVMQUKCYRIJRRCZKPWPLNPBIHQAWIJWEGPKHRXAVVRYRIDGWZCVMIIKUTQEBUNNEWBWVHWDYQBMTIIVFBWYWQOHPPBUCKGBUMFEOWXYNWEJKEYJPBUTWLIBJRQULVWSOHHUZYWZOBTYRUAROBWJXZIXTVGLNKKFGAAYRIQLBSVTNRREGIXKHXBMEOMSIDRYEMUFZTMSYZATTGXJLOXPLYJNOJWPIJJSNFXBENJNILQZKDGTVRUCKKTBYMQLDWVZJCTTKEAIVOVPUSNXPAMIZSSTYJQRXWGCHKNUIDRGBKLDQQOEHVEVRLCKQGRFRJWLHURSNBHHLAHJXCHHPAPGKNMERSLFNFAVXHZMGADMKSFPEQWCMNADVYHMHAMZCCZXCSQRUJNMKLWNCOQGRANWRZGWQYPVHNFQOQIXNJMOSSWNXZUZQJULNHZNMYMZDJZFHIVAGUPZYUTRAEROCMXGMMPTZXDDRWMBPVJOWUQUBWUHOKHJBSPVYTVVNIHGNMBHUBZTYCSOVJTKSBRJTAVCILRFUHAWORDCGHODNRMRXHGNPBAMXFADHKAIFEWACDSXLDWAOZQDOOZYAFIEDWOWKSTSWVSKJGMGGPNDRITPAQCKLYACAKXGQMGSFHEZNBWWBCJNXBAPBBMVXNPKDRVZKXGJCXOXUJZZATQERCUHRBTIDGRDTDADKRVLWAWKXOZSWSXGSUDFHINWAYZIVCLLPQAFCYGCVKKUGFUCPTDCBIEFYWDQLZBIWTSMDCWEGHXCEMAVAOGHRBTDPYWVZJAYBRSBBNVMEVJPIDCPPAFOXBOBBYETZUUIMGUIHWYTHROOQUSDHZKLLVQPNNFFZFQTFQNYLKCDZTDIUHKBQYHAQCPGXOQFFFQLEAEBVYCADCBKDWSSPEPFYZVKWLWYGOMJWRFOJQTOZBUXTHMEVNNZBDARRJUREQPZTLZCRSARAMDCESBASPDDCHKHUFFRFHHRWLHIZBARDVXRITNTTRWIABSICXREDKYJMRREBSRYRRUZRUPDYSDBFSHGSJHUEDPBNTSKSLZUTTDUFQLBVQDNMQZTJWUERNMKCRLFOAVHZFXHZBJEVXEIFJAZURGVMBFYJBJQNFXFMOHUZTQSDUELIUOYOGFEZMLYMPJCFJIOLRZSTTWTTWRBZJJDAJQAONMLYZBIEDYUZMQPDGVKEBYTJFEIYTVFTDGDKLDUFLPMXHNSDMPURWXXMEDCZBYBZEIVYDSAMPHIFVWDMHOBLOHUMEZBWZDJKGMRBCNJNWSBATONEBZPLTMMFDGUZWCOAEOXSATWYADHYZQZJNTKMFXUTDCRLLPLHFRZQITITDZTNEYAVUOVSNRVZLODUYMENXVIYNBNHDIVFXTPYCWIWGAGVSYTKMXAAKSWVJWQQUAFOUOJHTBWFBTOXXQFYXYDRSAAFEJGUKVBPNXJUGPBAEBDDPCDXNJVUWDUFJYATVDAEVTGVALAIZNJNOTZVUMPPPEJSDBUHOVLYDVLUTQJRPBJLILDSOCZYZSJFOHYHUFCYDYYTFJWIBIVJUAHCFPJPCDYDFEXBICTGNIIBIGNWDXJIQHDCYFADTJYSDGCHFUVJODFMPPOUPEWQUQFBWHJYPYXNEHKJYDVCTWUKZGNFCMAXWRLXJOVUCGVYYLAHNCNAVRXFAYWLFWEGXOEATKJBQEWDCKXLCYAQGELTISLJNGNDMSDIEGTZDJEIVYGKUITBMTDEQNARMDWBLOSQORWPUKJVJDNASJKSQIGCVHDNWUVCBYUNRSILMPVBBBYZCGEZLXKIBAEFSXOCWGPBKUCANOGYPIMRWQZHQCVMYQGXXBQJQEKMGDZZMZIKBVZVOZUJPWLKBSGGWBOISHEHLWEKRONPVHLWKCECXXLDRVRRDXDOLTPHIKIXUPSCXTRSVBWNQPSQHOBAIFDAJSTYVIDREDDSAHXEUSWAOMMTSGGUKSILWKYMKLHWZAPBMLEVHVWCYPYKQPIHENOTQJNNSIJAVQEUWFFMVZJNCVZMVEJDGUMBWZYNJBOQMAWBVNJXCZNLMUFRJQPWHBAPDQXGUADKOTAWHYQQHRAUFLXRTXNNKXYWZYPCMUVOWBORZGOUZHBVVKYPTHHDCZDRPNKBUKSTAEIOFEBWSREMPCTTZYDUCHYWRLSOBGZOQUZFDZYLWQQSRZMIXHWWRAMGIMUXWOZXCIRMGXPQINXNVEZTZAELZEHNKSERZHEMKRGXBMKJYMDVYAUZYRTNFQEZIBGUVYLKTXCQCNEUSFMGQRUQNMQZEZYDXIMINYFPLYKJBHQKONMZCKTXSVPWYJVUSZBGNFGFETFWYPJOYCOUKTBGCUSAAIEJEMISGJVHAFYKTRELMEZYXELSYWKIKZMTJKQDQRPVPKBNCDXNSKNYMGYCCTXONNMLOATKJSGEPQUWSWRXVZMQTINKXFPBLKIUHSSFEBPSHDVXRJNWZMCQTZFGODTBKFUTWGQCASNARKZVSAJZMWRCHPOXDPTLZVZXBYJVZDYMXUJMAFNARTSKCGZVMHFHOQDNUFTKGOJBJPIIIAKBHPZUFCQGVFUZYKMEIYEZSGDUXDCHDNUJCWDCLFAVSNWHZWWQZHUYWOUSAPXOSOXDVOWQGPUKWBLJGNOQPYOBXFZAMKJCVITKOQGWBTCSFMFJAPXUAENMSGVLXWMPVOIPCGMDQRBPNOJPVRQZCWNYMHFQFHPDLMCZNSWKRWSIWPXPYWVJAAUSFGJQUFGZTCLXGVGRKLMVTPZNCEBLYEKYYXEGVFJSDDFPAUIPISFFEXWJOXHGOYDXCHFASQHCIUGBHRIZKCEZQMYVRWGLUXCPTVMPEWSWYAMSZWDZNFWAAKRRDCKVWQNAFQCTCPBPURDODHWMKJXNAGWYHVNZMVPXHSSDHSATBVZGCXBYCMMZSARMRANMTGMWDFUFNJDVLVEQSVGZCKYFJYCYVBYFXOCQCLZKNCTJXKIJWXXXOXZGTNMDLPEXWTFFHYYGVIGAEQITLKEGBYEHIMTZVLFBQNRFKAXJKMUGDWCNBMSWEIKVGPNXMXIMBBFUWYJWDAZCXICWPXXHCHONTWEAOYJGQWYOKYJXOQTUFKDXZWLDUSCBQCJCSYCWRAEXZPCUKHNCAQQBAVFWUEGKTTKRXDGKAXHFAQQUGUOCYSENIDFINGGKFHRDFSGPRCNRMJSQGLGEAGRYVUEBKNPCHPJARWLVAMWXKLLCIEVGLQURKGELWAVMOEAQPTETSXDIWHTAWUHYDSWPBSBXSMILPGRJOKFWVFRYLLDZSNEODKXLCUBVCPZUMVCRMOKTLZWLUBDFVXDWXJQAFTGWPRHKSJVUHFEECTVSVSQWPFUBKNOEUWBEAYTWZLEBCFSBEHXRDGRVKDTBWBGEFHRWEYGLVOLNNDRVEYZFAKHEMLZNXIKCXOMMMNKKPEDCQAMNPHJZIDPYOFCZSAEXSDKCFADQPFNZOLXXPWHZQXZFEPXKVVZBDNFGOECOEEBGQKZRYZVNRRMACXGCZIKRXZFCPREJDGWDGDQWAUONDVIZUAHGWOEKFHZYFFWYGTTUWTHZMOSHCOAZAUQVGXUDNBDKZXLFRLJOOBBZWCJDOJVRQDZHOKWRGUIYLSXBLOYLVFCQXSGFKKNKCCRUYKHVSMMEGRZQUPOSCPCPXULPVHHDLJVKBZEQXPDELQYHAPNXPODAIXCHDDEZXSNHXFJRVYKYHPWWXIKKADPWHYECYZHRCPETXJRPVCJZTJAMTEVEWBOJJIHLMFEKRSFWOIHDPVWIEDCDCCWFXCUQWMVCSALZCFNSIMPAMPXPFFLJLQMOUKBMJPRCPZKGIIQRWAGDQHMBGRUNWCNPEENIMDFHNIYESXOCNODZHNWGWKDYNLRWVDGDCXZJWJFJAYOYMKGQAUGOUNOBMOXHYXIWXDTRRVZYONYDMCGXRXCSWMTFRHTDEPHAWRSHCFFJHQCOXIKFJDUKZEEFDUVMKIKWQFGEIRDRDCKNOOPZBVSVJMVCEIIHBWLPZCHICDXFYLWOTQNZOUEJRWXGEYUJKXYOHVQHOOLCADPQWCMKDZFCVVKRZOPUMAQYTWTNBLYIPJGZAGAAUZHMBNOAJWGVDUERVYKSCJTDLUZMURSWCBMBCWOMMPRDENOWUVGYCMXGKQAPOJWHVJXDQSTIVXEQQFFHRRRDIYOYPBXCHHASFSQNOXPMECLWXLWDVZNRBZPKQKWXEYBUYJIDSBHXRHANOMYGJLBXQRKXNDAYAKYYYFFYOPYURLNXTWUHZERXDAGNZICBABUDCUHIZOTKPAUUIQCWSXJKHBCYEEGHNWGJYKKNFMYXJOGGBJUFYMZUTQSZBIXQJEWXMLUUBTMPADMKMTPNRHCQZGKJMCEHNECPCNMNBMGLUSTXEYMPRWQSIYOBVQACAYHEGZZBUQAETEGHBNEWWEHJIEEPGHTPLCCWTFTRNGJFDNYZUFAZHROOTIEKQHRDDBOQXMYZMWUPDRCJYBIXGPRVUDAIXJKUSYSSGAOQCOAWXDDDGNRNZQBCOQVLENHJXLWJGVFNKLXUJYEOHJGFAMGDNZCANNYDNWBBZWGYHAPSVUXERUJRQPUUDXJBCQZKJRUFCDNRSRZZLNOCJJRQJORFIBXKCZBZKCVIVZJXMBUCOPUEICSWINZGHNUGLEAZMJRTKBEDIZZZRRCPMDEDKYXLZQOUDPEZVQWAIXDNBQHIRWPBFQRVHHKIWCNQKYEXPLNVMBKZBBSHVWMTRJSWGFTSZLDXSXUCSMPRPIILOXBHSPXZYDDLYUQNCLNFUVVOVPKWOCGGRZOEQAFPFQEFOKMITPTWQOJJQOAFNDYPPWSXVBVLQPDURHSOSUXKIHBICWYECZJWOSESPIERXVOWHVQFFDPSIVWEMCODLUKPJRYVLPZOPLGWAWPCRWSJTQJFHNYVRUKDMWHXNWFWNORKXITBSGQLKOJXONGPCJUHYKSCRBOOCBPBSRNHEHKSIVFHRBKTOVZTYIZPOAJZKJEXUCTUIMFTHNSGIVQTCXACILYTKLFLKBOCXHKLRFCLJMAMUCCOIXLAATDJTAMAVMWLHZXZFRLQMCYUUIVYWCLVSOWMBJFPZDEBSCWMNPLCPVJPLCLNAMLJWXOBZKWVXZUSWDCVEMEYCXKLKTIGXGXAORRISJTFSMYUUKOELSWWZLQWXWTKFIEECPXJXKFFQXGCFCHUHJNOBZHPIELFYLSCCDEKWOVZYWBMNUYZYBTBYKEJUAOLVGHVYSLHGLJKFONWUSRVSKYYIQULSXJDYTWKQZWWMKTJZDAPWXHSYNXFQSABTUULKDWRADFZMUDWNYYSXOFUYJAGWSXHEWLAPPZIYGAVYNOPQQRXGXQBURVMCENONTHCRRJTETDCLKTCDAOMRMJJKSRHBQRDDUUNQTYFGYMKKYOJOZPCTTRUPJBSVUAWDRLAOCRWQUHJIRHOEEUZIUJCSUXZCUDDLJPKIJDKHKBSADRUYGFZOWPUIYEIKMPTCQRHRSERZEYQLCKOYAYRVSKQZXWEDWYHZVQTZSUUMCWNCCIYHZPOTWBJGRAJQYXSEOEXXSOXNJKIHPPOSYVOOTASCHQGKGJKGLYJUOMWPDMXAJAUXCWJIGMFBNRGPYNTODQWFLAMNMDUKFFETUAMQDJBKJELHSYIIOUAGJBWVXIAXEDYZHRJZFDEQKFRCMHKTYCLPZBDMJHSQKDJFTLPAWROLJWGBWMDUIBQCBBULBOQBUELSLXVCMKNKNQJSRGKPVTICAVOQHUGGQKVDLLFJXAVEJEZVTUQHIPZOIMOCMZHGZCWWTBNFTWIZWSMNLENDMKNDVHTOPHRPTKQYMTRMCPBCXFOSASJGBVHNZYPDVOGFBAAACDAWYGFEEJZGYHVICHFTOOFRNQBWFCEXFBMTNWVBYZEZGLQLJWPKGIVMWNFYPCOEGKXXDODGBLOERJQNBTYYZHEXAPQANLKNISBFOAXCMIXTJKHFEALTBWPCZLWTHNQKQFUBORZELFSIKNQNNPCVCMERRLZIZJAAFKKJTAAKTIZAOLEFOLJWVOMSKDWKBKYSMSIOVKNWUVWXRIFMOQLZGEKQXMMSFNKBMRWTOQHQTDMICVKJPBUUAVAQRUZBHRACXSUVHTKNUCZFMXCXWJGSLIMPNGKSLUHTMZSGOHKVYCISVOFHKIQVFFHXFWXHPRRIVQNDYZBIKRHLIHBNAGDFXRTNPAWEIRBSDKGHQIZVVJCWMATJNGJDFWJYAIIAKVCKERNWKWQPAMCEVIGSIAYDBXWWKVBDYIAZLCZLXJNRKCYDWTRSAQRXNMCUKBMZIONMAUOZCYXQCSQIZNGTCMAFEDMHNRBXVAMDONIHHJWUWMKTDNBJLYCOTFAIPXCMFFUDZVUJUJQWHSXQWJZVZSLOCABVMVMXOEXPSTRNVBSUDFVABUTQYTNZDKIMXKUGGSOXODTUITPTDYBXMOJZLDZOPCNDVGQAMBAGURQCXQSUEHZZRDTSCUUNDTEHNFARXAPNHNHLQLPLTVVYYBKEWAOUDTKSMXRQTIDEWVQZCBSHMQWJPFXQWRVDFSQULKVHAEFRABFMAVKJQIHIURRCIOCNFFYKNQUCJPAROWBESUKYEWKLPQGDZFFTKWHBGRXELNCERMJNNDUKVWDTZPSKDMFSGJOOQKBVQRSNLVNCJKEICCRUQTKLBVGYGFLDERSDDSKIRVHYYABZQAKSBUFLQOSLMYWZOKOABPMBFUHWTYGTAGKOMTBNVJGTXDOJRXEVKVADIZODGLXNZESSLLRXNFKJVQKDNIUNJPOFWWZBWSNKQKJMDRWGPCFAWKYKZWUDQCYDSXSYTJVEOVJZOGCNQYOLIMWBFZAJIWOAXENANJVQOLMVLTBFCVHKFGHVSBQUBUGZSXLLSVCVFUXYPPKYRNIXJTAGJMMRQNQYFMRROKIUSIWCWCAPALNMAGGKVQAOXBHOOAVGPZJFXWXGMTLNHPZSM"

/*
 func morganAndString2(a: String, b: String) -> String {
     let achar = "a"
     let end = CChar(achar)
     guard let A = (a + achar).cString(using: .utf8),
         let B = (b + achar).cString(using: .utf8) else { return ""}
     var result = [CChar]()
     result.reserveCapacity(a.count + b.count)
     var i = 0
     var j = 0
     var pj = 0
     var pi = 0
     while result.count < a.count + b.count {
         if A[i] != end && B[j] != end {
             pi = 0
             while (i + pi) < A.count && A[i + pi] <= B[j] {
                 if A[i + pi] == B[j] && (i + pi) > j {
                     let upToA = (i + pi) > a.count ? a.count : i + pi
                     result += A.suffix(from: i).prefix(upTo: upToA)
                     i = upToA

                     let upToB = (j + 1) > b.count ? b.count : j + 1
                     result += B.suffix(from: j).prefix(upTo: upToB)
                     j = upToB

                     pi = 0
                     break
                 }
                 pi += 1
             }
             pj = 0
             while (j + pj) < B.count && A[i] > B[j + pj] {
                 pj += 1
             }
             let upToB = (j + pj) > b.count ? b.count : j + pj
             result += B.suffix(from: j).prefix(upTo: upToB)
             j = upToB

         } else if A[i] != end && B[j] == end {
             result += A.suffix(from: i).prefix(upTo: A.count-1)
             break
         } else if A[i] == end && B[j] != end {
             result += B.suffix(from: j).prefix(upTo: B.count-1)
             break
         }
     }
     let resultStr = String(cString: result, encoding: .ascii) ?? ""
     return String(resultStr.prefix(a.count + b.count))
 }

 */