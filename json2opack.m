#import <Foundation/Foundation.h>
#import <Foundation/NSJSONSerialization.h>

CFMutableDataRef OPACKEncoderCreateData(NSObject *obj, int32_t flags, int32_t *error);
NSObject* OPACKDecodeBytes(const void *ptr, size_t length, int32_t flags, int32_t *error);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSError *e = nil;
        NSFileHandle *stdInFh = [NSFileHandle fileHandleWithStandardInput];
        NSData *stdin = [stdInFh readDataToEndOfFile];
        NSObject *json = [NSJSONSerialization JSONObjectWithData: stdin options: NSJSONReadingMutableContainers error: &e];

        if (e) {
            NSLog(@"Failed to read JSON: %@", e);
            return -1;
        }

        int encode_error;
        NSMutableData *data = (__bridge NSMutableData*) OPACKEncoderCreateData(json, 0, &encode_error);
        NSLog(@"encoded: %@", data);
        if (encode_error) {
            NSLog(@"Failed to encode: %d", encode_error);
            return -1;
        }

        int decode_error;
        NSObject *decoded = OPACKDecodeBytes([data bytes], [data length], 0, &decode_error);
        if (encode_error) {
            NSLog(@"Failed to decode: %d", decode_error);
            return -1;
        }

        NSLog(@"decoded: %@", decoded);

        NSFileHandle *stdOut = [NSFileHandle fileHandleWithStandardOutput];
        [stdOut writeData: data];
    }
    return 0;
}
