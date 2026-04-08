package com.example;

import org.apache.kafka.streams.KafkaStreams;
import org.apache.kafka.streams.StreamsConfig;
import org.apache.kafka.streams.Topology;
import org.apache.kafka.common.serialization.Serdes;

import java.util.Properties;

public class StreamProcessor {
    public static void main(String[] args) {
        String bootstrapServers = System.getenv().getOrDefault("BOOTSTRAP_SERVERS", "localhost:9092");
        String applicationId = System.getenv().getOrDefault("APPLICATION_ID", "stream-processor");

        Properties props = new Properties();
        props.put(StreamsConfig.APPLICATION_ID_CONFIG, applicationId);
        props.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        props.put(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, Serdes.String().getClass());
        props.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, Serdes.String().getClass());

        String inputTopic = System.getenv().getOrDefault("INPUT_TOPIC", "input-text");
        String outputTopic = System.getenv().getOrDefault("OUTPUT_TOPIC", "word-counts");

        Topology topology = WordCountTopology.build(inputTopic, outputTopic);
        System.out.println("Topology:\n" + topology.describe());

        KafkaStreams streams = new KafkaStreams(topology, props);
        Runtime.getRuntime().addShutdownHook(new Thread(streams::close));

        System.out.println("Starting stream processor...");
        streams.start();
    }
}
