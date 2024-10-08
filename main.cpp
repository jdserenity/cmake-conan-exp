#include <fmt/core.h>
#include <caf/all.hpp>

using namespace caf;

behavior ping(event_based_actor* self) {
    return {
        [=](const std::string& str) {
            fmt::print("Ping received: {}\n", str);
            return "pong";
        }
    };
}

void caf_main(actor_system& system) {
    auto pinger = system.spawn(ping);
    auto result = system.spawn([=](event_based_actor* self) {
        self->request(pinger, std::chrono::seconds(1), "ping").then(
            [=](const std::string& str) {
                fmt::print("Received response: {}\n", str);
            }
        );
    });
}

CAF_MAIN()