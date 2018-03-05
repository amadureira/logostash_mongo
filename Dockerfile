FROM logstash
#COPY config-dir/logstash.conf /some/config-dir/
RUN logstash-plugin install logstash-output-mongodb
CMD ["-f", "/config-dir/logstash.conf"]
