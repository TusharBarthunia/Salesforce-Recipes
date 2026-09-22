import { createElement } from '@lwc/engine-dom';
import LmsSubscriber from 'c/lmsSubscriber';
import { subscribe, unsubscribe } from 'lightning/messageService';

jest.mock('lightning/messageService', () => ({
    subscribe: jest.fn(() => ({ id: 'sub-1' })),
    unsubscribe: jest.fn(),
    MessageContext: {},
    APPLICATION_SCOPE: 'APPLICATION'
}));

describe('c-lms-subscriber', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        jest.clearAllMocks();
    });

    it('subscribes to the LMS channel when rendered', () => {
        const element = createElement('c-lms-subscriber', {
            is: LmsSubscriber
        });

        element.messageContext = {};
        document.body.appendChild(element);

        expect(subscribe).toHaveBeenCalledTimes(1);
        expect(subscribe.mock.calls[0][2]).toEqual(expect.any(Function));
    });

    it('updates the message when a channel event is received', async () => {
        const element = createElement('c-lms-subscriber', {
            is: LmsSubscriber
        });

        element.messageContext = {};
        document.body.appendChild(element);

        const callback = subscribe.mock.calls[0][2];
        callback({ message: 'Hello from the publisher' });

        await Promise.resolve();

        expect(element.message).toBe('Hello from the publisher');
        expect(unsubscribe).not.toHaveBeenCalled();
    });
});
