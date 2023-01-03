const { postTournament } = require("./routes/player");


const routeRequest = async (event) => {
    const body = JSON.parse(event.body);
    const action = body.action;
    const routes = {
        postTournament,
    };
    if (action in routes) {
        return await routes[action](body)
    } else {
        return {
            statusCode: 404
        }
        // TODO: not found error
    }
}

module.exports = { routeRequest }