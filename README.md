This project is to demo Apple Bug Report 29814616.

It seems that using an AVSpeechSynthesizer in any way (I tried several) in iOS 10.2 results in a lot of garbage being spewed to the system or debug console.  It happens (1) when initialized and (2) during and immedidately after the first utterance.  Whatever is going on apparently also affects performance, because executing the initializer `AVSpeechSynthesizer()` blocks for 1.2 seconds in iPhone 5 simulator and 1.6 seconds in my actual iPad Mini.

When running this project on my actual iPad Retina Mini, I get

- 9 lines of garbage upon running the initializer `AVSpeechSynthesizer()`
- 18 lines of garbage upon calling `speak(_ utterance: AVSpeechUtterance)` for the first time
- 149 lines of garbage after all is said and done

When running in the iOS Simulator's iPad Retina I get a little less garbage, 145 lines total.


The remainder of this file is the result from running on my iPad Retina Mini:

2016-12-27 07:19:49.690917 SpeechBug1226[2159:863776] ***** Will create synth
2016-12-27 07:19:50.490419 SpeechBug1226[2159:863838] 0x1741434f0 Copy matching assets reply: XPC_TYPE_DICTIONARY  <dictionary: 0x1741434f0> { count = 2, transaction: 0, voucher = 0x0, contents =
"Assets" => <data: 0x1742654c0>: { length = 1229 bytes, contents = 0x62706c6973743030d4010203040506646558247665727369... }
"Result" => <int64: 0x17403dfc0>: 0
}
2016-12-27 07:19:50.509417 SpeechBug1226[2159:863838] 0x174144150 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x174144150> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x17403df20>: 1
}
2016-12-27 07:19:50.510000 SpeechBug1226[2159:863838] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:50.511410 SpeechBug1226[2159:863838] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:50.526104 SpeechBug1226[2159:863838] 0x1741432e0 Copy matching assets reply: XPC_TYPE_DICTIONARY  <dictionary: 0x1741432e0> { count = 2, transaction: 0, voucher = 0x0, contents =
"Assets" => <data: 0x174266440>: { length = 1237 bytes, contents = 0x62706c6973743030d4010203040506636458247665727369... }
"Result" => <int64: 0x17403e1a0>: 0
}
2016-12-27 07:19:50.535040 SpeechBug1226[2159:863838] 0x1741434f0 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x1741434f0> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x17403e220>: 1
}
2016-12-27 07:19:50.535423 SpeechBug1226[2159:863838] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:50.536635 SpeechBug1226[2159:863838] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.055294 SpeechBug1226[2159:863776] ***** Will create utterance
2016-12-27 07:19:51.055545 SpeechBug1226[2159:863776] ***** Will utter
2016-12-27 07:19:51.081419 SpeechBug1226[2159:863776] 0x170143d30 Copy matching assets reply: XPC_TYPE_DICTIONARY  <dictionary: 0x170143d30> { count = 2, transaction: 0, voucher = 0x0, contents =
"Assets" => <data: 0x17026fa80>: { length = 1229 bytes, contents = 0x62706c6973743030d4010203040506646558247665727369... }
"Result" => <int64: 0x17003dc60>: 0
}
2016-12-27 07:19:51.085566 SpeechBug1226[2159:863776] 0x1741439c0 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x1741439c0> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x174220240>: 1
}
2016-12-27 07:19:51.085804 SpeechBug1226[2159:863776] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.086092 SpeechBug1226[2159:863776] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.087998 SpeechBug1226[2159:863776] ***** Did utter
2016-12-27 07:19:51.182486 SpeechBug1226[2159:863845] 0x1701435a0 Copy matching assets reply: XPC_TYPE_DICTIONARY  <dictionary: 0x1701435a0> { count = 2, transaction: 0, voucher = 0x0, contents =
"Assets" => <data: 0x1700792c0>: { length = 6477 bytes, contents = 0x62706c6973743030d4000100020003000400050006025702... }
"Result" => <int64: 0x1702355a0>: 0
}
2016-12-27 07:19:51.187395 SpeechBug1226[2159:863845] 0x170143a70 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x170143a70> { count = 3, transaction: 0, voucher = 0x0, contents =
"Attributes" => <data: 0x1700792c0>: { length = 528 bytes, contents = 0x62706c6973743030d4010203040506232458247665727369... }
"Result" => <int64: 0x1702357a0>: 0
"SandboxExtension" => <string: 0x170054040> { length = 271, contents = "2b02576a73868dd752c278f5c098e2c24de8a2f6;00000000;00000000;0000000000000015;com.apple.assets.read;00000001;01000002;0000000000513f52;/private/var/MobileAsset/Assets/com_apple_MobileAsset_VoiceServicesVocalizerVoice/bd610ebf3cdee47a506b603c116b87c052feb5e6.asset/AssetData" }
}
2016-12-27 07:19:51.191196 SpeechBug1226[2159:863845] 0x1701430d0 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x1701430d0> { count = 2, transaction: 0, voucher = 0x0, contents =
"Attributes" => <data: 0x170261b40>: { length = 528 bytes, contents = 0x62706c6973743030d4010203040506232458247665727369... }
"Result" => <int64: 0x170235a00>: 0
}
2016-12-27 07:19:51.202883 SpeechBug1226[2159:863845] 0x1741439c0 Copy matching assets reply: XPC_TYPE_DICTIONARY  <dictionary: 0x1741439c0> { count = 2, transaction: 0, voucher = 0x0, contents =
"Assets" => <data: 0x174260b40>: { length = 6477 bytes, contents = 0x62706c6973743030d4000100020003000400050006025702... }
"Result" => <int64: 0x17403cc20>: 0
}
2016-12-27 07:19:51.207158 SpeechBug1226[2159:863845] 0x170143700 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x170143700> { count = 3, transaction: 0, voucher = 0x0, contents =
"Attributes" => <data: 0x170072840>: { length = 528 bytes, contents = 0x62706c6973743030d4010203040506232458247665727369... }
"Result" => <int64: 0x1702363c0>: 0
"SandboxExtension" => <string: 0x170240900> { length = 271, contents = "1476adae939682d7887df71a882cc67717cad7d8;00000000;00000000;0000000000000015;com.apple.assets.read;00000001;01000002;000000000036c21d;/private/var/MobileAsset/Assets/com_apple_MobileAsset_VoiceServicesVocalizerVoice/b42ef77f9de60534a8f5a56d277d965771dead47.asset/AssetData" }
}
2016-12-27 07:19:51.211913 SpeechBug1226[2159:863845] 0x174143bd0 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x174143bd0> { count = 2, transaction: 0, voucher = 0x0, contents =
"Attributes" => <data: 0x17407f500>: { length = 528 bytes, contents = 0x62706c6973743030d4010203040506232458247665727369... }
"Result" => <int64: 0x17403bc80>: 0
}
2016-12-27 07:19:51.216931 SpeechBug1226[2159:863845] 0x170143700 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x170143700> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x1702363c0>: 1
}
2016-12-27 07:19:51.217265 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.218063 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.221221 SpeechBug1226[2159:863845] 0x170143700 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x170143700> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x1702363c0>: 1
}
2016-12-27 07:19:51.221464 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.222025 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.224446 SpeechBug1226[2159:863845] 0x170143700 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x170143700> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x1702363c0>: 1
}
2016-12-27 07:19:51.224662 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.225287 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.228305 SpeechBug1226[2159:863845] 0x1701430d0 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x1701430d0> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x1702363c0>: 1
}
2016-12-27 07:19:51.228592 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.229031 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.239379 SpeechBug1226[2159:863845] 0x170143700 Copy matching assets reply: XPC_TYPE_DICTIONARY  <dictionary: 0x170143700> { count = 2, transaction: 0, voucher = 0x0, contents =
"Assets" => <data: 0x170273500>: { length = 15365 bytes, contents = 0x62706c6973743030d4000100020003000400050006064106... }
"Result" => <int64: 0x170236220>: 0
}
2016-12-27 07:19:51.245707 SpeechBug1226[2159:863845] 0x174143180 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x174143180> { count = 3, transaction: 0, voucher = 0x0, contents =
"Attributes" => <data: 0x174072640>: { length = 526 bytes, contents = 0x62706c6973743030d4010203040506232458247665727369... }
"Result" => <int64: 0x17403bb20>: 0
"SandboxExtension" => <string: 0x1742459a0> { length = 269, contents = "b7f63f50d3bcb5ce0e54ce32fe58b2feccf71941;00000000;00000000;0000000000000015;com.apple.assets.read;00000001;01000002;000000000003a05a;/private/var/MobileAsset/Assets/com_apple_MobileAsset_VoiceServices_CustomVoice/e430eab7b5ff9d9f556cc51f2900431ee439e437.asset/AssetData" }
}
2016-12-27 07:19:51.251387 SpeechBug1226[2159:863845] 0x174144200 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x174144200> { count = 3, transaction: 0, voucher = 0x0, contents =
"Attributes" => <data: 0x170274780>: { length = 526 bytes, contents = 0x62706c6973743030d4010203040506232458247665727369... }
"Result" => <int64: 0x170236b00>: 0
"SandboxExtension" => <string: 0x170241110> { length = 269, contents = "d04f732fde2e3abaaad935f2e16a58436196edf8;00000000;00000000;0000000000000015;com.apple.assets.read;00000001;01000002;000000000029e55b;/private/var/MobileAsset/Assets/com_apple_MobileAsset_VoiceServices_CustomVoice/f1e9b59ec0c1edae7b0d198bfc842023f35401dc.asset/AssetData" }
}
2016-12-27 07:19:51.256156 SpeechBug1226[2159:863845] 0x174143bd0 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x174143bd0> { count = 3, transaction: 0, voucher = 0x0, contents =
"Attributes" => <data: 0x174071b80>: { length = 526 bytes, contents = 0x62706c6973743030d4010203040506232458247665727369... }
"Result" => <int64: 0x17403b300>: 0
"SandboxExtension" => <string: 0x174244770> { length = 269, contents = "dff0ad3bb598298108a0104a69d652a83e6c416b;00000000;00000000;0000000000000015;com.apple.assets.read;00000001;01000002;00000000003ba697;/private/var/MobileAsset/Assets/com_apple_MobileAsset_VoiceServices_CustomVoice/7a7ac33264b2dd06075fb71f5ef6c3c6d69ff56e.asset/AssetData" }
}
2016-12-27 07:19:51.260598 SpeechBug1226[2159:863845] 0x1701430d0 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x1701430d0> { count = 3, transaction: 0, voucher = 0x0, contents =
"Attributes" => <data: 0x170274dc0>: { length = 526 bytes, contents = 0x62706c6973743030d4010203040506232458247665727369... }
"Result" => <int64: 0x1702373c0>: 0
"SandboxExtension" => <string: 0x170240d20> { length = 269, contents = "8857977f91d85f7581b505e5de8db9d495145da8;00000000;00000000;0000000000000015;com.apple.assets.read;00000001;01000002;00000000003ba6e7;/private/var/MobileAsset/Assets/com_apple_MobileAsset_VoiceServices_CustomVoice/443285a68f2c7ea9c9642444a7a4cbc788b4e2cd.asset/AssetData" }
}
2016-12-27 07:19:51.266498 SpeechBug1226[2159:863845] 0x1701430d0 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x1701430d0> { count = 3, transaction: 0, voucher = 0x0, contents =
"Attributes" => <data: 0x170274dc0>: { length = 526 bytes, contents = 0x62706c6973743030d4010203040506232458247665727369... }
"Result" => <int64: 0x1702373c0>: 0
"SandboxExtension" => <string: 0x170240ed0> { length = 269, contents = "14e445d6e699a148be148632e9f1d41c52fa19e1;00000000;00000000;0000000000000015;com.apple.assets.read;00000001;01000002;00000000004d4d32;/private/var/MobileAsset/Assets/com_apple_MobileAsset_VoiceServices_CustomVoice/a5c67011a7113689338b4c2b150bcd3d2d722f79.asset/AssetData" }
}
2016-12-27 07:19:51.273845 SpeechBug1226[2159:863845] 0x170143390 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x170143390> { count = 3, transaction: 0, voucher = 0x0, contents =
"Attributes" => <data: 0x170275140>: { length = 526 bytes, contents = 0x62706c6973743030d4010203040506232458247665727369... }
"Result" => <int64: 0x170236d80>: 0
"SandboxExtension" => <string: 0x170241230> { length = 269, contents = "80be42f1a2a17b72a81bbad0ed09ccc01eea1395;00000000;00000000;0000000000000015;com.apple.assets.read;00000001;01000002;00000000004d4d5d;/private/var/MobileAsset/Assets/com_apple_MobileAsset_VoiceServices_CustomVoice/f4efc8e985d5ba8891f1d3fd3afeb582ec969ec2.asset/AssetData" }
}
2016-12-27 07:19:51.278502 SpeechBug1226[2159:863845] 0x170143f40 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x170143f40> { count = 3, transaction: 0, voucher = 0x0, contents =
"Attributes" => <data: 0x170275140>: { length = 526 bytes, contents = 0x62706c6973743030d4010203040506232458247665727369... }
"Result" => <int64: 0x170236d80>: 0
"SandboxExtension" => <string: 0x170241200> { length = 269, contents = "2d480f7d6532241b17d3853cd2cc4de5e65936c5;00000000;00000000;0000000000000015;com.apple.assets.read;00000001;01000002;00000000004d4d87;/private/var/MobileAsset/Assets/com_apple_MobileAsset_VoiceServices_CustomVoice/cf076413d6df72e3bcfa6358662c62bb0fbad94d.asset/AssetData" }
}
2016-12-27 07:19:51.282559 SpeechBug1226[2159:863845] 0x174143c80 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x174143c80> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x17403b3a0>: 1
}
2016-12-27 07:19:51.282865 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.283950 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.287280 SpeechBug1226[2159:863845] 0x174143180 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x174143180> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x17403b320>: 1
}
2016-12-27 07:19:51.287520 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.288039 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.290778 SpeechBug1226[2159:863845] 0x174143ff0 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x174143ff0> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x17403b3c0>: 1
}
2016-12-27 07:19:51.291475 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.291901 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.295353 SpeechBug1226[2159:863845] 0x170143650 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x170143650> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x170236ee0>: 1
}
2016-12-27 07:19:51.295583 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.296210 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.299923 SpeechBug1226[2159:863845] 0x170143a70 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x170143a70> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x170236ee0>: 1
}
2016-12-27 07:19:51.300231 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.301105 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.304592 SpeechBug1226[2159:863845] 0x174143180 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x174143180> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x17403b420>: 1
}
2016-12-27 07:19:51.304838 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.305388 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.308213 SpeechBug1226[2159:863845] 0x170143650 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x170143650> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x170236ea0>: 1
}
2016-12-27 07:19:51.308429 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.308929 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.312729 SpeechBug1226[2159:863845] 0x174143c80 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x174143c80> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x170236ea0>: 1
}
2016-12-27 07:19:51.313015 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.313594 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.318750 SpeechBug1226[2159:863845] 0x170143f40 Copy matching assets reply: XPC_TYPE_DICTIONARY  <dictionary: 0x170143f40> { count = 2, transaction: 0, voucher = 0x0, contents =
"Assets" => <data: 0x170274b80>: { length = 2881 bytes, contents = 0x62706c6973743030d4000100020003000400050006010701... }
"Result" => <int64: 0x170236d20>: 0
}
2016-12-27 07:19:51.322679 SpeechBug1226[2159:863845] 0x170143f40 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x170143f40> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x170236d20>: 1
}
2016-12-27 07:19:51.322910 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.323461 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.326044 SpeechBug1226[2159:863845] 0x174143910 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x174143910> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x17403b980>: 1
}
2016-12-27 07:19:51.326255 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.327066 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.330801 SpeechBug1226[2159:863845] 0x174143910 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x174143910> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x17403b980>: 1
}
2016-12-27 07:19:51.332076 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.332745 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
2016-12-27 07:19:51.336448 SpeechBug1226[2159:863845] 0x174143180 Copy assets attributes reply: XPC_TYPE_DICTIONARY  <dictionary: 0x174143180> { count = 1, transaction: 0, voucher = 0x0, contents =
"Result" => <int64: 0x17403ba00>: 1
}
2016-12-27 07:19:51.336694 SpeechBug1226[2159:863845] [MobileAssetError:1] Unable to copy asset attributes
2016-12-27 07:19:51.337484 SpeechBug1226[2159:863845] Could not get attribute 'LocalURL': Error Domain=MobileAssetError Code=1 "Unable to copy asset attributes" UserInfo={NSDescription=Unable to copy asset attributes}
