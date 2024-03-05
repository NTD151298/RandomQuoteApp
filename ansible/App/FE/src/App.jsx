import './App.css'
import { useState } from "react";

function App() {
    const [quote, setQuote] = useState('')
    const [isLoading, setIsLoading] = useState(false);
    const fetchQuote = async () => {
        setIsLoading(true);
        try {
            const response = await fetch(`${import.meta.env.VITE_API_SERVER || "http://sample-webapp-nodejs:3000"}/quote`);
            const data = await response.text();
            setQuote(data);
        } catch (error) {
            console.error('Error fetching data:', error);
        }

        setIsLoading(false);
    };
    return (
        <>
            <h1>Random Quote App</h1>
            <div className="card">
                <button onClick={fetchQuote} disabled={isLoading}>
                    Give me a quote
                </button>
                {quote && <p className='quote'>{quote}</p>}

            </div>
        </>
    )
}

export default App
