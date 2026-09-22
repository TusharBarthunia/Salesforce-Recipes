import { createElement } from '@lwc/engine-dom';
import LmsPublisher from 'c/lmsPublisher';
import { publish } from 'lightning/messageService';

jest.mock('lightning/messageService', () => ({
    publish: jest.fn(),
    MessageContext: {},
    APPLICATION_SCOPE: 'APPLICATION'
}));

describe('c-lms-publisher', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        jest.clearAllMocks();
    });

    it('publishes the typed message to the LMS channel', () => {
        const element = createElement('c-lms-publisher', {
            is: LmsPublisher
        });

        element.messageContext = {};
        element.messageText = 'Welcome to the LMS demo';

        document.body.appendChild(element);
        element.handlePublish();

        expect(publish).toHaveBeenCalledTimes(1);
        expect(publish).toHaveBeenCalledWith(
            {},
            expect.anything(),
            { message: 'Welcome to the LMS demo' }
        );
    });
});
